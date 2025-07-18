Return-Path: <linux-kernel+bounces-737014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FDB0A6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA6A43AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C041C8610;
	Fri, 18 Jul 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpMdAUve"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8612F50
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850410; cv=none; b=A57xmCIinNBohDZb0lcGfw1uHKSTbtoJxMQ8+xHJcj4nwpKBSc6xnZBMwy1dKSJRFBLUt0bGCS3+0VUSwNgHzHrpFGGOW8ixxQIRqhrW3q9JL5aRSCmn6dvwgGqf26VrNT+L+RAUvkkJrgqR1TLA4TrMZzi5zsCreUdVnzUhDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850410; c=relaxed/simple;
	bh=C4j1W7PuydHxpWCrJnq+RnTeRRJNesJnNoj0JHTHqfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsl9LV1fZstQLh+Mz0VwJm8imQpeqHce3HQIGO/3YdPCW1R4D4CI7TfHSLcmEaX+zdyLeq2Bhx5hRNunGFXX+U2WwSWkinS7N3cAy+mfDRkdXwLaMqHmjKy3lfBtAi97MvxfPjp+eIXf0eS/JUJIr0RYqBl1Hr3IHhC1Ll0MNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpMdAUve; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-611a7c617b4so551737eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752850408; x=1753455208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDgeBH2oH/qESW6dpF6eUk0T2Y4Sci3Ik9kvwkFXKJM=;
        b=fpMdAUve58f/HFjbL98UpQxU/sXlI9/Fzqcn+IH5Rl17gztm7mow2YH4CKEwtcKshP
         uZ5QK3R4zOWpuYX4frogzuHJ+ScDegxvAwwRNUMlkkJFrS6rfP32571oveMNKP5ohHzA
         TG56ewqXMIs+ClTphuzE7hnTAgBndNqI2kneoh4K0d92I8IKhrey22WYHqJi1TN9NdHE
         tY0JCDGeY9v9nB9bkV+8sSFO6UHIQGZRFtNfB3Ro1D38oR/2t9QVbr9XZYz4/gD6f2fz
         eVfZiOVSfPjTT8VFwt+7XlOJcxrDp0APxFj3gkENe8MrjhoGiHhoPX6Ge4qTHFwXHaSP
         7fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850408; x=1753455208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDgeBH2oH/qESW6dpF6eUk0T2Y4Sci3Ik9kvwkFXKJM=;
        b=gYTuuKYTEG47hQl6lx9ar9C4cHfq9v8iKUIblDBRusBR3nRN+RjdEEtqtm8YjKb4rv
         rzFo+ed8AKVnQxv8GFqWUKYauHPEAsVUVF+SZwXrN10qPDBDmyL91yRkkpIgsBsYoU5Q
         P140rYUzqKLQIEO1yHKjPB1FNP8JfSAnzl03STCreFbGFIchlrp6rz4d6eOdUUU4MsK8
         IBLGC8QrmHHENGVJTQHhaqqzkcd5fltEdmLcrLiIePwDrJXwU7DlAnLlwkmuvVDbueaj
         EvAaEELCzJShz87joLNd0ZxRX5CexOLjQuaQQuweTyHZGcZ1H0v5WOjz1G1OmagImcMR
         qBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGwniEd799YL/jWy6zqGdbiv5mQ5QG/ekm51s2VRKSWH6dWq8hw83qWvM0gg5VllOun1S/O2sr0L1KTZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6HCtasghHPhgVi4+qrwPb3+L28f0vQrgzhcL13R8f5K5ejnb
	FFT2At3CYC/2DtZyASFdX6coh++IWDao4mVM2qY3hdQMpKRMVOD39JFgSO4kspOPE7A=
X-Gm-Gg: ASbGncsHnVS5oNPyfOJkgOmzrtpXX3mV1tDcZr4ARQU7qh1k30msiqGSlS2JWC6aDV+
	OPH/lx5SN+ty22gAaPs05JAl8YZgs9PhOTmAAPmJ2e8PMqsp3QaBeQbQch8/bYhmaSAVdxZ/TV5
	gwe6KZWGBKfZEt8VTFRkgd8uTSMd2oJd763jtwpyW5FH9fdn56Pr/2Foi1xvSd/ZDeUPOCk7gV/
	bvM5St9y23UX++gYrMULPagx04Bq2Cr0kRnmVWPIvq9nCxllNIx6ZPBNhnw2BuemH+7DeMfwIb+
	apLA+ffVErwEuZ0+4mXBcP8dbzut63N8tcbTPX6WXZCkUNnTNvls/KNvlscOcyqy7cIh4Ve4ktY
	FBXJmsWaUS7Q9HPW7k5bQOe8pALOxVw==
X-Google-Smtp-Source: AGHT+IGPhzFCHREIPi0nFXZL9YZJzmn64Udn2fqdwHgXC4Arvxph+F5Rddp6XkQErVZSyQoiAvgKSw==
X-Received: by 2002:a05:6870:7886:b0:2d9:3868:b310 with SMTP id 586e51a60fabf-2ffaf2a2ad9mr8519060fac.11.1752850407866;
        Fri, 18 Jul 2025 07:53:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83605aeasm676624a34.16.2025.07.18.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:53:27 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:53:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: make const arrays static const
 char * const
Message-ID: <aa4a160b-1f0d-4983-8532-bd22214d7114@suswa.mountain>
References: <20250718034913.49300-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718034913.49300-1-ignacio.pena87@gmail.com>

On Thu, Jul 17, 2025 at 11:49:13PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> This makes both the array and its contents immutable, which is the
> intended behavior for these constant string arrays:
> - g_fbmode: array of framebuffer mode strings
> - fixId: array of framebuffer device names
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>

This is a v2 patch.  On the first version of this patch I told you
that it breaks the build.  So I guess now you're trying to fix it
by making fixId const as well?  It's unclear.

Anyway, it still breaks the build.

regards,
dan carpenter


