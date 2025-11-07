Return-Path: <linux-kernel+bounces-890768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CFC40E26
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1871A3AB560
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF1280CD5;
	Fri,  7 Nov 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqmDBTM8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7C27E056
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532853; cv=none; b=qR5/D4FWLlzzpI1igf0j9wJngI+c8/R0B5vPngyAiWjJf/fDBZ8skw+L4zAOXoWQ4p8JGlcckghwd9ol92OIXsO+Op3+4rWbsfDQB19039clXxXjVXcsdl4tftye4hhySBspfu950k8NgLuHCQQO4oRStzmAtE5KizNUlYWgBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532853; c=relaxed/simple;
	bh=1ZYlBp5vpzPi34x0DteKqN4nKqjK+cKdtPyQq3TItws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfhqkENwPAatp2lzVOR6rtpI3zaNKjN3GjV2Via1avH10/SBrHaYNuNm0zK8Yv077d9IVMlwxcaaphrubeG23vhwak8Y6++TRkzMBDU/ijZBYi+lmh6UZa+XSwys2Xqh13c61FVs4/7kkEY3wb4wPRi4OEAhsox/rJMZF4Q+rF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqmDBTM8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so666097a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532851; x=1763137651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CX1ZehLJDso9stJ9f5XmyHuDOMwQijlKUUb7er1MnaY=;
        b=WqmDBTM8gPWM77vtwaHmx+1j904Lid0Hy/sfAaNW4TY//lfjGeEGBYZ6nb4WjP5jdg
         1NFbT04HmNE/tYGWZw23pKxKvPzx716uZNMukN5o2aeRGpzGbolfD00zwcRcdoATvCkr
         y3l8yptfY1ZiAaH7FeGjuf1sTBUlrCGuhx9WC0vNJ/0P3qNHbEVl4M5stIH+HprCSt5m
         seQQe73WYE4BEat4HtM+QUioYQ/Qjdd6c+2aDETD5JzFB/5kwtBVPJX9/mlIt8MtrX2k
         k7Wuu+upKG0Xmqmyx5yt01q/uETTW7HlnT3euhHT1BedQRE5wcRTAeBFyxJBz0DlGyJW
         VNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532851; x=1763137651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX1ZehLJDso9stJ9f5XmyHuDOMwQijlKUUb7er1MnaY=;
        b=E4acRAG4LfgSy+7e/kbsNzMxQJbcHyunG52K4/S1jNaDXUsplLPYaxzhyox8xnS/bS
         JufZgU/jdJdgk33Bf0r5+DaG26dkzDrJd1J3HnhQfd9FlcVFja5uwK3oHAqD97gaIniA
         U2yvHz1iDrKjQsSr9vY6RvbzCwwbnPrvvVWP2Db9LJjPBg4HYfS4FgDbBOXEkphSwaeY
         n9ZTV4p5iV7kTudR70Q0bDUkFdI00DHDDHqU2UcFKi8z24xSUwoJRau9UyNrUlVk40au
         XLoJE0wcWWSbe02DcIjCUk3OZISODr0H0sTC8z4oN1LNJbVDA1dUX8ob8n9+KHW7DqHF
         OgOw==
X-Gm-Message-State: AOJu0Yz9irdvPQBj3vChAbHksog2IX2j+03W7rX+9l6XSh7Y4KGzQjm1
	zEa70Dk60VggCgTmxH9KZHPvJL+AUIdfSyKEptYf66/I8uftczgySY3W
X-Gm-Gg: ASbGnctoaQlDR2womut9Mg+of066rdwEttYIGq7fe5ImtV695C/uEKTtKh06vjYnYhp
	8pb6UTUJbw9JPFLpfX+tzgE09gvO+n8OVufmKn4t+3bMgn1oIUjqrCHMqtx9gl5Mb4prMUj3dIi
	HkP71xSgRQAlAG4pX8DEsqE4xA205qKBo6j4BFgcYG1z3gr7aNzCXDDxcRtGoWY+jNgpwokPA3k
	UcflRxzoEon+6IweLR5Vgf66iIrECNzMyNldi+2FUGsNyvZXmQQwVa5C52bcCNAjq+HloXXvRcj
	7SrBPSPxTUX0S9+ggBUcHXa5CGu63O0YZcubzs3pWPrjDmhVzV9WPheJmBmGn/FuLHmxRWuWBmL
	HVR5v0mAn+BR9llCwKXx7jpLAtCUt7idC5VY+mqDZa08MlMl8Xtp/QnN0NiupppxS5rjwkVJxQQ
	gE5kYNX9Stl5pyWYLBhFpy8Y08N8RRlaTnq6B7KfdFayJoo0K3aq5hntMiU88/wFAv1Ib642+nN
	ouoeDsuVwQPVUhdra+nr3nfREDfUoH2DRf5Meb+CKi9vlvugAUardCWYQ==
X-Google-Smtp-Source: AGHT+IEAwnhq8fVpucsSXNeRs61u6uV6hNbakIq/LMsapAkB8PACzzepguxOLcfPfbF4AVxuWJAoCg==
X-Received: by 2002:a17:902:cf0a:b0:276:76e1:2e84 with SMTP id d9443c01a7336-297c03873b8mr50136455ad.3.1762532850886;
        Fri, 07 Nov 2025 08:27:30 -0800 (PST)
Received: from ?IPV6:2001:b011:2006:fcb0:bce8:7cee:580d:599a? (2001-b011-2006-fcb0-bce8-7cee-580d-599a.dynamic-ip6.hinet.net. [2001:b011:2006:fcb0:bce8:7cee:580d:599a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651045bf0sm65289595ad.48.2025.11.07.08.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:27:30 -0800 (PST)
Message-ID: <04d5353a-b9ac-4ff7-ac77-5d856a10be27@gmail.com>
Date: Sat, 8 Nov 2025 00:27:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dapm-graph: Handle sourd card with space in name
To: Markus Elfring <Markus.Elfring@web.de>, linux-sound@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251106165802.3780-1-s921975628@gmail.com>
 <fe032b8a-b7f8-4e80-be96-72667bb04c55@web.de>
Content-Language: en-US
From: Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <fe032b8a-b7f8-4e80-be96-72667bb04c55@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/7/2025 7:01 PM, Markus Elfring wrote:
>> When the name of the sound card has a space between, the
>> script will fail to output the dot file. Consider the
>> case to generate it correctly.
> * You may occasionally put more than 56 characters into text lines
>    of such a change description.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc4#n658
>
> * I hope that a typo will be avoided for the summary phrase finally.
Sorry for making such a mistake... I'll send another patch to fix 
regarding these error.
>
> Regards,
> Markus

