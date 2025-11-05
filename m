Return-Path: <linux-kernel+bounces-886839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FCC369F7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F1E1A265C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB2156F20;
	Wed,  5 Nov 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqpSPRMj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF8333440
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358660; cv=none; b=KG89d4m4ELfSzjN10weRVr9uCY0Y02ACf+8LZqQlpxpGDuVcy97IMNuHMBtb/9+C2a+4IyQS2JkIn6Vh/HTql0NbT1xherubn+Mk7Lgsx428wguTH5pxy1hvyyq1oqr/AJvwKbzIZBZs1gbvLrjyc7JrqKcl4QbOBGSh/+kNtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358660; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS40onc+12q1/0j0tJ5x530kolvV4PJi1KcrDMM9Grnkk1fq6HXL4K6pedrDfBhuUrNMr3J8Tryb7FSdJ0rvVu2q/djO/fYHszs1QXJwtnDWSfHe1SFSHq6LYY+DxF6D2OqBrz9Ua8+GDNUwUd8LxeBwmLzRSvjjH4rw+mj9fdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqpSPRMj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b726997b121so133218566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358657; x=1762963457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=bqpSPRMjCQVmrJtPa26ktK2vYMifg3gFOZuXJxHd9oO60/Jv1ztnmQTWt6Z34lNslF
         gl7xwwDsMSi/YS6cL8ziKvu1EQRFVUakPd7LlVJZPzvkKsInJJSSJ3kz6lUcmWvdnUd4
         RwICeq5AgDU/14dw6TMHI6mtoY3lEGE2wLEAUZlGN/7YgIeObg0MF/J6WRqiYBTMAE05
         NgwxxRuT9In3/tm9n2cql/iJdfhgJqKwktpbPsTkBu9/ro0UEpHN3HsbF83vvfeoqrFw
         GaxKRjLgxf5XU2rplp6f90gzidkI0gb4JZfvEqBKhllLyVuxC1xqmHBOrBDsnspTf6Dj
         k+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358657; x=1762963457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=ug3SGRrd2tOMXPbAf4AEOq4BEmBQUwKmm4G+4MeoEDkPuegKd02fGzuhYllP8b4bpQ
         zjOvXSjQ0euBoEUTRYBVMAzJd11zmD6xjr/F8CF145cym15rqv392HoiPuvW+GWOtEZE
         KuMfp7naLEShB7rlfFyYdEj4+Yevjcsm4yNqOXCDhP2Xq8DsHJb8s7Gv5lx1j8oEJFD2
         Z9MKp62024Tw6WbG39MXczAALu741bObC97doe2IwZm/8eEGAa3L9t0ywV88bVdb7cl0
         M1XpnBbvvz8a5Tji+sfwJ1wwKpdafXubR7W7U/wUdSNXVCyBb2v6s3AR+hiTfej2ZABw
         BcKw==
X-Forwarded-Encrypted: i=1; AJvYcCXIX9jBsFAkkh74NCOF3Q+uUXLCKa9h8q5Um9ZO1X6eOcybJfL7WLXlZ1hcqV6RBiKBY/RHRueUswUzspk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIPeDR6Pl9YccZ6WlzRnfBRh0szb05O311Ivm6yk5bBJoaBJh
	KwEu3qggF6+YbOTleYwESQUDnd/1Dh7GR2RBQ9WVZjF++dH+7aq8fAApATptdDj60SQ=
X-Gm-Gg: ASbGncswqpkuaLxw6tNgbkzf47fMEuZneYgIizYFbi1X0QwgjdkicmGUIJM4cUDK+LT
	u0RtXyIdqypH7A52N6RXBpkhgg9ONRqV5Pf1kIOhYKo937e5K5+ceaE12IRAj/OdyfrHSrEnPLc
	sBkIH2miI7g97LjYBMOzpRWO/ic9nQt9/R3JL4YXgJUHIlMYdm7j8ZnrQXdNPsVlqFcRZwHQlEy
	51qGt5F83XEIzOgz9xOhhK5VGP+2AELTVNwREhf0wwyUgqi2Ayt3FVLM3ADHyJcO40aMIbmoD7S
	E+v0e12Zdwcl8MFKFT1073CIGnQ0Iye+XTk5R1ELEzGKti2K93+6CYm5SAiAudB/MXPkD6YebRI
	tmMrCo0bP6hFl88oV7C19UHa0KTZnCJRr2OhXQW7Br3o4MU6Hy586ti52T7kCEumKxjc1uAfMSp
	c7Znptk4LC1sLaIEAVMHhmYhU=
X-Google-Smtp-Source: AGHT+IH+8UBl88iOFcuJ5mLvs7y03FE0ImwwlDmWIzieFw+K4sIaLEleiL54hEot6DxqVBsb24f+9A==
X-Received: by 2002:a17:906:d54f:b0:b46:57fd:8443 with SMTP id a640c23a62f3a-b726323d55cmr451555866b.24.1762358657186;
        Wed, 05 Nov 2025 08:04:17 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa0828dsm518078166b.50.2025.11.05.08.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:04:16 -0800 (PST)
Message-ID: <89fc4526-db36-4974-8a38-554315fe76ed@linaro.org>
Date: Wed, 5 Nov 2025 17:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mtd: spinand: Add missing check
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-5-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-5-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


