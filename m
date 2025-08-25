Return-Path: <linux-kernel+bounces-784873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F56B342BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C287B2A2FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074212D29DB;
	Mon, 25 Aug 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="wNuif4lB"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2D20E029
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130672; cv=none; b=Dv2w8WFhhE1pa7CJVfJXRwa06YOxOG1gNuLEE+olZbowTiPIfLpqj8KpPS2NHqIs/LkpyRANw9JoaK7MYJjozHOHRtePT5oN1CNIxmIogEPmdUWbCL4m5R0TLPQibyIAWaUlxrhu2nrUk1f8Oz6yIwryL3aeH1cBIOmZcHU6kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130672; c=relaxed/simple;
	bh=/3DslClF26Tpetvdj2Tx6UdWgmJwjn0hLHzLQQ9qlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2dC7CjkwJNL3URPiI9Aeo1aYBo0EZI2R6unCt7BZwUjxHApqxvdIZZCXQUDLR7XlZuLMk7xSRJdH9/+cv9rSGkVCqVCoKt8sgZgaad3VNZCUYDtpel5GxquqOgvE2ZgWGIGPi3G4RDaugxsMG3moS23CULPEyyizjB+cjfTXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=wNuif4lB; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7451ee5e750so484091a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756130670; x=1756735470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0EHuRO+zWG4akDLUijfoOjIulcloDYperZFzqc1OzSA=;
        b=wNuif4lB6/kpUoVgXqM5YDN2caRlNIy/CHV9fyKN2whyeF1G5RhOHq5WlcnWiqueVg
         rSOhNT9khA5Ctu7mMxuMfJX14LAcSsnWhgAcBgCwj8dZ4LwQcfcPexGKClEyOxPzM0tC
         fPKMIbO7NEupj8QUTbdqwZux78LYX/kXDbMIbi6hzfu7QpBfQ5G/d3objMJMgDh/spLa
         IKKuRAdZpuozdeSxH/ls4hSzuMbwZtvFZkgMA5kjDMnRXjYYsL09KBOlycJCI7hPeQgD
         6KQO052z+QZa89ZiCMXRB3Hh9Q7OrcQkiDaQU4b9QqrbZktZc8OwARJfoj+RkSljV460
         sCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130670; x=1756735470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EHuRO+zWG4akDLUijfoOjIulcloDYperZFzqc1OzSA=;
        b=ELtCxl519SvEy3I8LsZS9cV3RgK33kalGqnleounvdtjv5vPmiebV+i/LH5zfXMuCa
         qDOAkTt8IjAYjSW6hq7CEfnWdJFX65/SQumJzjekYBVQANWOb/v1X0X96IOeptNXFJRn
         lQDL4q2VtXqHyggX61cD3XsG+ESgzTOBvyve7P4GYvWu4xkUFYoZG++WiWnipfFcfzrs
         sCAQRo+isZPIS5XRz2A41vkWnvRRaJNA7AlgliKSj6OfPrbc1kc175Wpti3BZm83OCXR
         9gC6s1c/OM7Ta4Va2PURW1i1LrSwDAszG6UsaeLDRdYe6hSXGSb7v6933VVSm82ToTiA
         TIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWGrsZj6CrkfVyN7E03Yno7uz1pr/rLiLE4M+zhX1qhyUNyOX5svQCyCc3CxGx4c1W7wCb5S6mxcEJiCNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lNl1kckLWAo+EAPXV/btw6+s/aHlZE4eh2aZGxMjfebds7Zh
	Z3xcuVztibyPVYZ4xoVpm7Iie8PileFgpeS5X4vHGx4dsZpNisdvl/CRQglB4rKv2Q==
X-Gm-Gg: ASbGncugZeIVlQYGbrBz2mJR758623pW8wydBzDG4dWBNcV5xYQciqEgggyg5j7sxuv
	8MnFu4IbVXeb8KXjHMYfkPBWWoLPtWOjpz+SEVJziPxT1+SqAkut9NGPfa7nhCfk44G2lBGsG5h
	hF87x0C4SnDG2lmwR+d1+Bz8dr7MBEE7rYru1tv7wDbBJGRSMnMaDq8o7/sweR/F9o/GSMyK1D6
	ZiUXMYNjz/ndsC7Xp4M9w5cgnDvHEGiEb2OjE6NItqILbYQofiFmEyl6hkJkCID/x7KIwcblveX
	o2w4o61LDnzoeAKg1gT7KWI6BK8pTV9mrOljtPhUJA9a2bgZ+5mRFf362nmPtq89Js3aTMY+Ym+
	6SXSUhB8Nro3GpnqWT/oCBDey
X-Google-Smtp-Source: AGHT+IHWk0LQpCvep194jbTPIE+rjYyZUcSUaUe83BGMBGS+W+nGqu++rpvaZOJE5FTJIa8Te798ig==
X-Received: by 2002:a05:6830:3709:b0:743:bc1:e85e with SMTP id 46e09a7af769-74500909d36mr7863102a34.4.1756130669721;
        Mon, 25 Aug 2025 07:04:29 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:156:8000:24f0::eb06])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebecb19253sm495628685a.8.2025.08.25.07.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:04:29 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:04:26 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: =?utf-8?B?6Ieq5bex?= <ccc194101@163.com>
Cc: gregkh@linuxfoundation.org, jannh@google.com, rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: Re: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
Message-ID: <9b6056cf-5803-40f4-967b-e064996c10fc@rowland.harvard.edu>
References: <20250822024602.42894-1-ccc194101@163.com>
 <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
 <4cdaecd1.131d.198dedeefe2.Coremail.ccc194101@163.com>
 <379c80f7-aa01-4575-aa0b-d64ef01c1346@rowland.harvard.edu>
 <23f1c6c2.2011.198df066c15.Coremail.ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23f1c6c2.2011.198df066c15.Coremail.ccc194101@163.com>

On Mon, Aug 25, 2025 at 10:19:56AM +0800, 自己 wrote:
> According to the current experimental findings, when userspace encounters
> an error while using the previous file descriptor (fd), it does not proceed to unbind
> and rebind automatically. Therefore, the two uevents were added in the kernel to explicitly
> notify userspace to unbind and rebind.

Like Oliver said, this means that userspace needs to be fixed.  Not the 
kernel.

Alan Stern

