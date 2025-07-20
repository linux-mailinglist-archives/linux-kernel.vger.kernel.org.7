Return-Path: <linux-kernel+bounces-738110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B1B0B463
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4243A21B5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37A1E520E;
	Sun, 20 Jul 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BptGVRfK"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6717741
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001796; cv=none; b=I2n/fEnGlv6PUOtjXsaLbkWS90jQoNXL7LBxTrUoibnO8okl9glJCrvRwXbO5HJ6uOHYMKyDe1NuyLxl9QzSDtaw/2dLu4o+fUlrwh6rtxkMMRLW10Unop5Gekf9tgUSFtfJX7dNaOItE/hN0s3J+Dvu9tReqeOQwuucSjJSGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001796; c=relaxed/simple;
	bh=Wq3qfkFjnnPBi+LkFUS9iBSulokfDrAkTnxAGm2dDBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/4LFlGpAApkAQGpqUBhgBXmgjjuJqgzwkPrLg2DxVHLsUM/xBSCRNI9qkzq/wFHp7XZIw9VvnRpxS0YUz57zd1hrh6+lpUbNGQBshE1SHJLn6MVYs0cVKfSdesMYTSfyvazcVx3/HcEL9H8KdNenCIdB6o+ZjY5iw4d3TG6XCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BptGVRfK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-700c7e4c048so57256366d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753001793; x=1753606593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaBLw4cxN79dHE/geNbV3aXF5eBOGZgGTlBqCuMR8ko=;
        b=BptGVRfKNdpGokl7Lj7ZLKM3UAXxewufCHyNTqaosYLtMtykXXSkko1rQcGOE0dYcn
         IbSJrHnsAoY+T42k4d3AXxT+mOeh0f7V8HZMSQOOiB30zt38k9By1OWgDhXKb8xfw3ev
         aVXhY9pZ3TVBW5XkaCLbAHzlolEQxi4kQY4/T+Km9GqsA2cAqdPQ98tvxfiJLBrJIE9i
         k2Va7DhKOiy0KFaBy/HqRtiaLGMc8Iqo+rG5DtSV+P6ZGI0Zbg0pYp67TAvdNiFwOK63
         uyAFxmIAIjvrjAWj80NE94GMHOFFj1NI1BPLmNMUUEdg7+qbV6dR8LZPM3uiIofrE8vP
         cp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753001793; x=1753606593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaBLw4cxN79dHE/geNbV3aXF5eBOGZgGTlBqCuMR8ko=;
        b=NBb+zw62zZ1UMYW4YfflmBGnUqteYPERp1K9Pg3YbQzlhhypopCahS8Olof1Wwk6jK
         cgwDxlsiaAUNGpwEVzAjo8LVsx5xr1Ke4QXdCb2HdH42FsyU9VyPld6TBxhLcr6UNSQp
         GrOEdWqEFf75kmUgZYHjhBrCfs7zMTIQCWMLJJVUIHBLwfFkL/ZLyn/C+QxNI6rLSIGf
         hwhgLkdPn9T568tI+gPTIOCsbqmXrAK9TPFDHxR67XEoj5CDIcKG4r6nfGQSMC92aD7z
         COTEdXqOOr2eNtlegROUNP8R3Fa3nzDK0DPMZ7n2u4Li01ZRaB2RDAmzZGhJfdU7ziU6
         5ENA==
X-Forwarded-Encrypted: i=1; AJvYcCVmOduB5iYar0sX2AMPVTYk1NTZXRe4rQpUeCQLSB5jLyFdJlGjyQo8pf3ju/QweAK54EzHOz/k4mNF0VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJMM2mRIuAyK8m2UmKNxLpUvKNE0+m5iNxepIV+sCdoSSLEon
	y46mne1v+wLWGn0hCuAgQLJT1amXGaN9V6kIzcXN5UgdblpYsY4mf9YLai32KQ==
X-Gm-Gg: ASbGncvHJ4nFXCJUdYQVpWO22Ow8TsP32QfiSGyXRpEfUYClq0QR4umFSPC5YJaphks
	krUjsRsLxa/+YOI3V22ZkQOyoqFSCMooLMTw98CzvEZz8KyrgiNsFlKWQBcN8AHifLaHk0Am1UC
	eT6jUfPTW6BGFsK0naHvbO3gE0LJbzIzeYQHdEyxYkCgMI/LWRRh1QjtKbaFyPVmtihPhPe24W3
	r2+BNSHJQFinUD3xMys44NWqXDUom3CobsXSOutURdJRL/rihMopPTFlcrVFORkVZ1gD8NE3BB4
	H2k1VpGXj+mJkCLPvhfVHYhA9ZxZsEYCvFOwh/OJU/6TN0aTHx5RTx56shgAptNqyosAYU+FzG2
	vsjgOHuo5lgGe
X-Google-Smtp-Source: AGHT+IGaDRzUzyRYiTB1TwqXeOom+POlmHqVcbb5nhd0aVvrfcE+cnApjZGvqybNZWRCqhau1torqQ==
X-Received: by 2002:ad4:4ea3:0:b0:6fd:3a4d:363a with SMTP id 6a1803df08f44-7051a114011mr133354666d6.25.1753001793236;
        Sun, 20 Jul 2025 01:56:33 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b907ac8sm27045996d6.37.2025.07.20.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:56:32 -0700 (PDT)
Date: Sun, 20 Jul 2025 09:56:29 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <aHyvPWeN_4JmPAzc@pc>
References: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
 <aHskWESzZdyBFj4x@pc>
 <2025072004-karaoke-stilt-ef20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072004-karaoke-stilt-ef20@gregkh>

On Sun, Jul 20, 2025 at 10:33:47AM +0200, Greg Kroah-Hartman wrote:
> 
> This says what you are doing, but not _WHY_ you are doing it.
> 

I did the replacement because pci_enable_msi() is deprecated, isn't that
enough ?

Best regards,
Salah Triki

