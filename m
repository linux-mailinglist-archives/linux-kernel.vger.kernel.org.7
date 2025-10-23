Return-Path: <linux-kernel+bounces-867144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97752C01B11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCD8B565B47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13FF322C8A;
	Thu, 23 Oct 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ZX3m06/1"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF8319879
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228495; cv=none; b=sohBNXvRTPIoyzc+AbkKMZ0Db+puatcieNJng1kV5GCGXjMsihGasVEYfIgeI0mZ2InWUuQWrA2zWaGrNmdZMl/PVDiUqeN0NMA9F/pXKFFVYc8VppOVR6i3iSjbaLno3v37/6uy6tWGbQLSpXZcTaD8CGzwrtB/qzUIy1za9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228495; c=relaxed/simple;
	bh=n4X4X7SUyozPZ0bqAovQu3/scLwKjNDRu2a99yczp54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeHRzu4OTKhnqN2q9tzA0INvzsOvB7U7hi6+pG1hYbB3OLMK2sYVr2DuBLAOoZtq+byXtal+OrA1mwoxsaSXRPWMhKbEmOr31rbZ9Iv15i0NnO3V1g7ndvB8a4wONAtcS3wTpDCWUlPygezNcISNr64IpJKzD3UCESmAE2htmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ZX3m06/1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso515487b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761228491; x=1761833291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQ7dzjI4p/gbkTSgLFIgujWu/iSPV8tz3wRWmntWfM=;
        b=ZX3m06/1bRnovFp8NUYLBc718CHb1wXSmXpAANcmPS8DCiqgZ7rctp/2yrwz1TE4C+
         rXHiDHSmb9JQnQ2++g8O5dhYtKRcn8jCbv59wWzWXk2x/N/wu6vuL4DM7+7Okr6acvxw
         IDMv2c66wm3voWzC2N0tCVd/Seae0hGWTjGS5rad90+emxbr5Fge7K5BDIP3lmPJ4RD2
         dEdT/cC992aH2+wHJy/tFofCe8lJKm58mDMo6B6KT9+II+ypQBLZ0SyyARl6A65fp/IM
         qCDdGlEQ0kCq4JHxCmmrW4ND/7ChSkeD1etukhAJHrJvUgJebPF2rPlvn1cl1b56iiMO
         ALPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228491; x=1761833291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNQ7dzjI4p/gbkTSgLFIgujWu/iSPV8tz3wRWmntWfM=;
        b=CrYAlBMONGuhPg1KFdSDmBuwU6wcL6ekcoqkqX53Cw0dsUwiQv8CEcBOP06lzJjQQo
         u66YIu5iONAGp7/38j5mBeEDeNq/aIEBiW0+3Ic7HF/S7Pt5MWklHQzli0jfOTWbpciu
         bE+wIi9JTq+vBQKFrWzOtIab8Mqp1K7esDLuhF1aiTqRvgqsHoaf771VKBAM6mzAFitG
         nMOq+tlFVb7qX95uHwS2fB8C4QB+diJkyxjsgqrPs2Tc4Dq9OEFMriu90MMUPpa68QbM
         ec04FHeJ01cjPsUlgAoSHJ9DMAYMwGSHbgcuAq4VCuKHuOIs6e8l08aOOu8hrYTUxiMO
         92Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWLGsgPopkns89eKuBafFcKMrsmEXiDZ4u+ByFiq2KYl8R4LZO83uOpND1LqGqj9LX1DB0JEz8rmNXR+9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvtGdE4Y1FoYTLh/ENjb+w+HgHD9IXaba2ZcAo4/SegPP/PBr
	YsWDvh44SIi4cbg9UbZC+FoJ1xME2uuBHEG8bpL3Sgpzn3SLhma4fs0CZP7xM83k6R4=
X-Gm-Gg: ASbGncs6a1+DTS5EGJvN8kq2H/SYToeWjn54F4h0BNoJZpuQHrGLAKVptgf2om2GgTE
	8UU59RZ6akj4q/3l+b+dOBNkLuM7zxCWFv5VeU/p0x5DWlE8YrVpkJx1HTKxv5q4s3oao6pEaoM
	et+gGmrRoQmdMnNNylIiJtv3i7oEjBhU1T1by+jTYyJ6QAFz0ueawMxkvd6vpnmmYlsurImCb6e
	d9+hkbEVTWa5nfCKkauNRmwPkpRSJmT2ATM8b5ScELWrrcPEYo9t1UOvBx3LEa+iNoIn+SzeKAO
	S38aa2X+7Ox6ygIHjgRmGnIZNw595paGCIZatU3cEvj1pOVu+UQpPrEJyNc/9l5Fc2SD5yJP4so
	6eLPbhCYe1+u7VGAhDwDDCakG0ldrwHjVl1gV0FqFAZsSoLnJEJXS3oEOBXfVF0fK
X-Google-Smtp-Source: AGHT+IFIk1AEgNDS635FrgFPUtF0AK+SRPzmZol9htufxZ0vVKc560nqGu/0gFmh5PqFsYkr17F4Sg==
X-Received: by 2002:a05:6a21:328a:b0:334:97a1:36af with SMTP id adf61e73a8af0-334a8523ebbmr31319934637.13.1761228491245;
        Thu, 23 Oct 2025 07:08:11 -0700 (PDT)
Received: from essd ([49.37.223.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a3f0sm2213697a12.20.2025.10.23.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:08:10 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:38:02 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, alejandro.lucero-palau@amd.com, 
	habetsm.xilinx@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix potential memory leak in
 efx_mae_process_mport()
Message-ID: <3r4emi6jl3nswdh3tq6krikg4ecxci7mpbmjrxlqhgrv77fnrd@a5blbfyjmjtr>
References: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
 <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>

On Thu, Oct 23, 2025 at 12:27:19PM +0100, Edward Cree wrote:
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> It might be nice to also add a comment on top of efx_mae_process_mport()
>  stating that it takes ownership of @desc from the caller.

Sure, I'll add the comment and send a v2 patch.

