Return-Path: <linux-kernel+bounces-898481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB30BC55607
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852A93BDD80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE7299A9E;
	Thu, 13 Nov 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="SyRnn9wI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916052877C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999000; cv=none; b=rm1Ck+C12ySwe61n/lKdKkscFeRSCpkivpiNWJ4IrXghu2D0/4ow8jYIHaFbTBe1NnfY/cezfH/bxJ27UNGIvTBPG+PAX4fzFvEgAYMia2xlpeoBL2plQPym8m9dlpMPoAZllh18RmpSuJ7tZr6BHA+yxSNGa0zckDpJDDa+NWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999000; c=relaxed/simple;
	bh=dKuj/ZSHvfq50pVJAtWFPSs1RdsG4DU+WNiKSJgFSHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3+8CyTXdb8g4egaIQhZhKM0RAgsCrdAhTJSPvXZnOPBC6uarqmMN0LRmNvIa3ltOSjChN0Cu7ZLGbGPccFQGvZtrYImobog3q57kZKc3SHv52CbPPD/tYO2IKaeylVtjurXzxg5p5+o9G2dL2YVGY0+RYVGMAW/yY7A3JSC9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=SyRnn9wI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aad4823079so251493b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1762998998; x=1763603798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVWnU1CZft0ittXMJMFPMV38gYnCD3S/zh5BMLPyXNA=;
        b=SyRnn9wIU9UtAEiJZRxwbE5N2c2In7FBShRrAjVuIs6CZFX8Hq126QwONBBTBp1goR
         mspCZGjWnHr2NdtSxZrTJmJh+mmMd7yrjR8ejkxdFrgB2OLPs1G48sSHOj2qtBsJDW29
         3s692WMUNlmO57gWV+cKJ+cLLGCK6H/Zy2JcCmdE2HSVbPhs8++hNitQM4AR4ayw7AmV
         guCM6qjz07AurBdlH6GJ0jkrW2bcnbORnwDoZoyAI6gvZ34tOmCYX//k8gsTwkyJGa5Q
         L+oFR9+A85NacYRYLFWHYxXheFLduOhHbqFTaXApQRXxjzNZHEW6ZExV5itz8aOv6dWu
         HLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998998; x=1763603798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVWnU1CZft0ittXMJMFPMV38gYnCD3S/zh5BMLPyXNA=;
        b=gbIRlmE+90j5p12xvnj7ZFG+v7j7tVuxIE7KRqgn2kC5db4F/8iRkeTZcVDsQLgsM9
         VgCbvrnaQdSsrC3jzA+FTaZTYtKQ22Naw/b1Or3v2poqEKdGGh/RAdV6zbh/qBF/uWEY
         ES0BI1RHQ+1NTudOVu8xqnB7cgOHkVuYeLCqhC6TumWczrXV7eiZ4CnHKl2lHD3v/lzR
         cyA1zdST9itqJGUXqkN77nw9vNuzHZv7L/w/YqmI7DsNPUv4LaYHML0pAxbN3Rh7JcnV
         FBCnIVhIQKmv5NUsUzxYIkwpYiz5xcNWsPFxA0HzURgXH4Wzn7mpHikJxKPiOPhjxp0k
         QGdw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4VBplHwRaXRaDBuSq9jhGqw+JpXAPM90kssXQQl6q8Cf90qQ55Z+rUbz5ARQiBlJuVd5uc/ZivMsYKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBx+asVb4A+mhoMUc/FU7RlMuDkiCd0W95+gkg+qGJKkBzOvpL
	KElv1hMJq9vdUNdgsjRpu9Sqt2pxIkMXjqp6bQcbvWee05kp2AbbJrwDGquK1PaDhEtM
X-Gm-Gg: ASbGncusKCNALiNSNrb0/yiDemenI2gywDOPEtiMIXQQdNuC1+GsZd6/lYsgqFYfTet
	HRgfFpFyJ0rlmfX4iYn96Bw5qLv6mLnI3woZmrE/sUAbPbr3m41YY4ISm+gGpEu3auyK/GIsrGc
	8uSDvZ5c3Djcwi/9a1l4YtFwyS/ZUKqAXScMkN0iCkt2IZZnDcrSQniEvPJJpSSgCQrOAt5BYha
	VY2rEQSMKFVIW9/H3pWhc3UiQrfJutl59KxIeO0P2k5uPlbG+j7j5QoTbuNXrC81igPxmzBOiUj
	Hvse9CPHHtQ3UcPNc5P0zM4YadzkvAEGmMXWZHaIsTxOBFQTnCd83R8G4wdD0qX8ZdaapoaCshV
	p1IFjs6QkP4T77C8YnIpX9mJ/OxQ4+l67qR2f+p3AyUX5s2wZlTRR2HeYLq4DM6aur9P0bgmowu
	C8nY50NXr5DV1mhTONRDcqIFvMXszpURmMMzEZoOfy
X-Google-Smtp-Source: AGHT+IHEbZmLflN3bexQUBqBxwVsx4Zvx/rxh+HoCzmVBKdRm8H6UivAf07OhDcPO8D8Lh7w7xDGIQ==
X-Received: by 2002:a05:6a21:498:b0:342:3b8a:f349 with SMTP id adf61e73a8af0-3590c2011a1mr6270904637.52.1762998997773;
        Wed, 12 Nov 2025 17:56:37 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927d1d128sm380240b3a.73.2025.11.12.17.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 17:56:37 -0800 (PST)
Message-ID: <7f061d12-0166-46ff-be38-33f6acb02a49@chenxiaosong.com>
Date: Thu, 13 Nov 2025 09:56:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] smb: move FILE_SYSTEM_ATTRIBUTE_INFO to
 common/fscc.h
To: Namjae Jeon <linkinjeon@kernel.org>, chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251102073059.3681026-13-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_n3D=CC9DfVTak3oQa3xqkQ2jyHm9sUKDLd=exJAuXJQ@mail.gmail.com>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <CAKYAXd_n3D=CC9DfVTak3oQa3xqkQ2jyHm9sUKDLd=exJAuXJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In the client-side code, SMB2_QFS_attr() needs to get the maximum and 
minimum lengths of the FileFsAttributeInformation. Using a flexible 
array would require more extensive changes.

Thanks,
ChenXiaoSong.

On 11/13/25 9:23 AM, Namjae Jeon wrote:
> Is there any reason why we can not use flex-array ?
> Thanks.


