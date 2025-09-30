Return-Path: <linux-kernel+bounces-838156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B291BAE913
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA391944C35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A4E289805;
	Tue, 30 Sep 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH+G8FXF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F08155C97
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265241; cv=none; b=NRqdPbnvkZqWbT040WYRTf3zrWHyR1MVzx/Z2O7JVkcpIdrl3XAGWTqgD63YLjYslBv24F8TwvRAQHzBPfb/PR05Dz1BgpWKaVDuneWecmmfyBppQRvSRpZEhqxFbLdM0YZqQHDKyrL957GqZvQBwznu1Fjjaaqkg1SlHoRS7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265241; c=relaxed/simple;
	bh=PQp+mzVn36GMibrfg+qbvSy27kf/GpxKYLgRVzy/VAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAR3jEN6nJ2vJUTSZRFNwpVDCMKp9b/JKJyTL/+Vkp1v94OzDTutemlD8sUn5+0O0VDV5UBS68IiaztlPzDpT8lVw07UUWorv7LXndQNQnlbEYl+NG3WJF8xDou7+74inJ3je0rZ5Xbx83bpOI22xIP/9JWxhOsNzeHhc/E9UmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH+G8FXF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78a9793aa09so647279b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759265238; x=1759870038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4q9dIY27yfmOm2lPjdRxqNm8D5c6q+pKNbNue3M/Deo=;
        b=LH+G8FXF1J44xHhM5DL+mnhgvpj0UTb54kLxG/iAfWCYPWecp4nyJOfW/nn0GPj/0k
         scuFKZ7Se7sNbW2pljPxRl9kyDkJhPiThknGBqqJ2N49k+qmjJLBtmJuu60rOGaASL8m
         lR0H9ik/CmXcZTvm/qgXcD3mRnErWcLiBPkxmt10LH5FLua+e3TUAcvbz/vjABsVwNIy
         B4TupSJ/IorcszD0uR5Tr1YnlEZXtl+A9wsRrx9iPSP/hOum7kOC0X6rs/ueB9ArGSax
         34viyktohDL3hrivT0/3rGVgW3LG07oZEkaQzO3k8/TtRd/t2WV6TB+hCGEjcfBMxKZH
         rCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759265238; x=1759870038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q9dIY27yfmOm2lPjdRxqNm8D5c6q+pKNbNue3M/Deo=;
        b=ZIQwb55GBSMt+wFOCco33PJzxuYJtTMbh4pd5CJh/10j7PD5zOTtvTIJkX4Z8eQKqE
         mm7FqwzQW52DbooESLKdhUsy9vM1AEB8tBYck/oGnz5OHiqXqj/n/yxX04jy/djEuHHV
         Bci9f/BewMI5Wm+6/PDexJfUREyPcYIJ20L9h7jb9Wv9SmXblnNZXBs3OyKxNCY6aG94
         0nr9KkGVntepHphy5QTCdQVWi6kxoizh8SqcxKKKu2fMeXv50cLAQL+HGmjyJFMySvaX
         4ICaOMqdkRCjvDxJAbuhG2HaBZL29va/3LQJbEGHzl5PMAnUm+q4tO+8H9UzR+kiW4tA
         rROw==
X-Forwarded-Encrypted: i=1; AJvYcCUZyvkajzWcREu8+BpaPaA2YJC/PU88eMeyTfklkjDFZD659WGYGpoLjyPJqf2DSHybG23dSA9Z+CMwqGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBD+fuUdIbBAyCBTRE07UGazs5bjrQbDMWVUZPn3PfzUr5jlpp
	/ThnY4BK3mxS2JwPFT62nOfNputW+ruoLfdpLRtN0C3w/eetQeZjCMA0
X-Gm-Gg: ASbGncskZur8K43IvBZTWoe5BjahQa81M5f2pxx4imcMmeMgrpZJamsk2TpoTO5fDlI
	zkyIcBrNxorZliXkYljHrXK/7h8pCfhcrDuSBTvSYqm3hR+qCIwczAiDq+bkPqOCI3vN9hYesVL
	zYJAU5SiExr58fH0HmoIdtDh06XejXvIfXn/PLFAwWRD0lw05ioY0DM+OjgAZipCW8LUcmBkteO
	zA5npioIE+c7bu3Brf6WTQRBsaOe0eos+DVzz6/CwhOG6NRL6TgivI0V04cxpW6ki8y1MkDD2/c
	7DYYaMY/PStz0S48WLqLQbPznlq/gF5yVg30fZdnB2g5C4OUlvbT+IjoNDjZo/RHr31D5HejVJA
	jYaoGuIOhVfZTCOZCi2OD00NyFjivUfSMcJV1WXqguRVbQ3aMJq+O3GSGbpEfxKkVwr9l+Z8MHo
	MIaA1+rzw/Y0U=
X-Google-Smtp-Source: AGHT+IEC6dRFuhURMrPckMM2r4CsW2F51u0tQLeeyg+l2I+P6VWKxeFYlVv/8UkXSsU17ocJM17U8A==
X-Received: by 2002:a05:6a00:2da1:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-78af4160624mr780730b3a.19.1759265238375;
        Tue, 30 Sep 2025 13:47:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7998:b3be:d4f5:19f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b64a87sm14641306b3a.69.2025.09.30.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:47:17 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:47:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] Input: aw86927 - Fix error code in probe()
Message-ID: <3ei3j4hkws2konaabofa7vc373n2uam7pycppzxdmnrie4efkg@42kbpjocrrna>
References: <aNvMPTnOovdBitdP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvMPTnOovdBitdP@stanley.mountain>

On Tue, Sep 30, 2025 at 03:25:33PM +0300, Dan Carpenter wrote:
> Fix this copy and paste bug.  Return "err" instead of
> PTR_ERR(haptics->regmap).
> 
> Fixes: 52e06d564ce6 ("Input: aw86927 - add driver for Awinic AW86927")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied, thank you.

-- 
Dmitry

