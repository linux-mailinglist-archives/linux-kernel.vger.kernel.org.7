Return-Path: <linux-kernel+bounces-815431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D2B56424
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC157A5747
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3A1DF248;
	Sun, 14 Sep 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYBkNmZz"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D81D9324
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811850; cv=none; b=ev3eUaS8nCQpsFbr8XtUy+OVfV8sYptHSA1w86bXtwwm5r8kcOWWylhNhSRKYeHQ6fJETdk+C+XZJE9l4vO2Xy0NxiibA4nbLrhFSj1Ryxa25e3yapcVsY6k93xNjWwrLC79BoiEyo/tP6dLuL1W4RpSrE4KrMT8lyFmMmlGomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811850; c=relaxed/simple;
	bh=sXDskx1pHKUhsyRk4wnDL5fpcdP5rYakGAvizdofSKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZi9NMa5EWMYcHDt2EjnjfOhNcACJ6F5HXybds1n1XzljZc1FrAVO6m5W1PIbDBJbnDGcVhgPG4+NXvEScWAaecY8/n4IBvMzhmc6xpDxc9uUJUXyluLBF4O+MdDlh5hBcLBYyDDG1W4Jy3STDPTVMQWuf4X5vpKMP3sTVdAQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYBkNmZz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2921447b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757811848; x=1758416648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pS2DRBcNvFIKJohLTH8vUf3BrBi5wwLcfUnLVRJuUM=;
        b=cYBkNmZza8YaDWKJEScw63owql9iY1zoXjPf+Aeo3pX+CvSvdU+21QIed2y7LWX3aN
         p+nKkysLhyc62v7gsv35DevyBbnwMf7QJHtvH69XpOZgW74XTuhe26yju2HP69wioIFr
         dWtmc4lcPd9uHiJs33Jn9sT2LLCQfsjQKvi3FnrZga4OL1kNMRoXshtMfIephOp6oDWf
         /m6WXPyhsd0PphRtMjYB81PoQt2LDhD8Q2Ne4+yNOCEQGKUIm+FQgGgQRzBTnF7oZoTf
         8SXWAY83GZRG6z5nx/BQ1fIhwiHAT5iRgD7z4wKUIM3wQ06OIM1SrCVwyXzVIHNgqFO/
         40uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757811848; x=1758416648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pS2DRBcNvFIKJohLTH8vUf3BrBi5wwLcfUnLVRJuUM=;
        b=BITMSHKV8A1tM5+BY8yob2hG0P7s0gyqMdfQsigpkueMNZzoUwaWPa3HYM+ihU8I9G
         HNvWXm3Ke19tswjJG1CNZ/1jOl69/CWqoxSBW2Bd5G6Xnr0D9TxI3pKqS+N2bVstVOQV
         uv4J+FLjpZSBvM9uQ+sXU/m6oHPKSLsbinpAwnAEPFdtrM1lHq6OqcReqSF/kUkIploF
         t6Yc91JVgBFl+lCdHpFHHw67lN/jAoWlWENWuXhj5QxcUGFRTj3dlSpny36Sx1HPsGfN
         v3yGFHTgWoMws0UN5kY83c+J2IIYOB3Bj6Yh5SCr+JvlZfCTMoTp/Auj+5qpdlK6+bGS
         xzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFp5N3ni+7H9oBZovUgntBKkRZ3ZMiyvdQH48JY1Ko1ReIiVJuPgAlGD1DDwEEkcAL3LxL+ycu7dRFxDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwboaLxF7WAod7y+0WYxiQpPYDNRDZXLAVq6Q45L08gFI7HUlUl
	4iV/oNB25pTyAfmJWbpTtVhPhga6OPq52iWLnrXFMtMGDeuqCZp2XvMY
X-Gm-Gg: ASbGncu1cnsKWTd6ec3F0CQy1hofJqrrErufsbNWB4wnDnlyhgN5WSrCGZe0A9jx5Wm
	rNyIk33HC4/UT9Hexg6f4xZMBcXXa3wA9wTOhgIROAkgUEnnO+pg8KjMUu+beeU7P0cg3qBjyNm
	svPgu9ahY93rWGSIT6oNTtNqTKvKa8cbYJj8JjLjGnJRVMd85eZJpDmkfoy2x5Ft8oE/F6IsuvT
	oxk9mOXwlkDip+L2m70p6H9+RyhfWqwwUsLnb32F52nJ+60cEZZu+f8oBY8Puagj5FxuGZ8N9Il
	yiIXB1K4GYcEdpeUOd5Sv0gAbtWfqXoG2elJpMuygTHglW/aFDmKpaCLiofcAsneJA/k5NyU3Nu
	/bzONiwhyEOm9687I5nupMA==
X-Google-Smtp-Source: AGHT+IFdV6SKq+TGgyDQArsbIgWlBA9pxvOaDnkpzT+VbVAP/25LeqPRmkZTK555qqZNaCRxU5POZQ==
X-Received: by 2002:a05:6a00:1881:b0:776:1d55:55c8 with SMTP id d2e1a72fcca58-7761d5556f1mr5467317b3a.4.1757811847675;
        Sat, 13 Sep 2025 18:04:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47310sm9078733b3a.27.2025.09.13.18.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:04:07 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:04:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>
Subject: Re: [PATCH v3 09/11] Input: MT - add INPUT_MT_TOTAL_FORCE flags
Message-ID: <rksu7ejddh4n5ojqsihqelyvc5m3cx5tc5zspdsa5ke72yxyye@gq2osygbtxsx>
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
 <20250818-support-forcepads-v3-9-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-support-forcepads-v3-9-e4f9ab0add84@google.com>

On Mon, Aug 18, 2025 at 11:08:50PM +0000, Jonathan Denose wrote:
> From: Angela Czubak <aczubak@google.com>
> 
> Add a flag to generate ABS_PRESSURE as sum of ABS_MT_PRESSURE across
> all slots.
> This flag should be set if one knows a device reports true force and would
> like to report total force to the userspace.
> 
> Signed-off-by: Angela Czubak <aczubak@google.com>
> Co-developed-by: Jonathan Denose <jdenose@google.com>
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

