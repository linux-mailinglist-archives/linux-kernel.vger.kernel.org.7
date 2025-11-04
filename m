Return-Path: <linux-kernel+bounces-885259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8377C3266A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 546AF34B5EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF033A02D;
	Tue,  4 Nov 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNbOMyTg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BB332EDA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278047; cv=none; b=Z4baknxB6Rw6T47RVvEGBVYiPjox2B068HWYdVG65PWj0fp0gTMv2/eIEnOGomc6nkqbGK3NSDXZtCLxL+gSU8UYgYSVcBlUDZJtYDSCsPwdseENJwSZ27KPgPs5I5xOFAC3FegK8jxk8wvOO5uB730pmlGkHgLjYmrKr/+PjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278047; c=relaxed/simple;
	bh=Wx29MHBm2RXDiUAmF5T94+hpdR6eJPgN69rPPWd5OmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/L65ze4hV3HD2KcOBqZ8salrdi66PjlpBOS63K3i5aQLLkcGld9Hb9F+D+pCowIMgvC8qruwg+WXYvCHdWn3B6vnXqDl4HiDOxdRllRj7zodMIisRbe0VQXBu6bmo7tt/LgEc12XZ87pcorKDZqPCVl+xpyRSQRP2g3NYkhG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNbOMyTg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47114a40161so10477445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278045; x=1762882845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvW8YZNNPsNEShPfc1BYhe9HoTHxi+BogUvpfvWJsZU=;
        b=DNbOMyTgQCJk5uWQmJY28FtcTW9l3t60aYdvUiOQGriS6xhNjt79re3/eUNxLw22fZ
         SJQX9ubMNKxc4gbE+qOu+eS3xm/fsrrCLmRKJAYgQ6UD0ryiw9KuRBq3DWHZ2aUbWE94
         vHkxNVQdZiqf6qIPpEHsQZ0h3YZHPQi2A+StO6FZROYSGHl1Iz9DoHoQTrvnhM6YuweU
         2cM/xjEMyohTQfKkGCBP+RjPpTUgWsfYigd/jS+mbsSEZb+/6RlK8mJLoHWJZX3dDjOR
         xP/0kJMmkptus7p0+sBG6W9AvPiX+w9pjNveYPyMD2M/un+jvidV15nxMK05ciUhJlRm
         rBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278045; x=1762882845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvW8YZNNPsNEShPfc1BYhe9HoTHxi+BogUvpfvWJsZU=;
        b=ER8PioNi2Nwomi4sXapi14SvykgW01I2F+S/QMzmpef5hrStfP/+w+xzbE3pogff2f
         lM1+2wPIIQZ/r9XpB+6JjuyIdcuGwAMIkfnF44N51f9vf25D/bi+JbTGlLNuRW4ZIyzT
         jTX6asvtBuOGR0dTMPV9UHIY8+LecYqh78KmqohLMm64GSWfTjTxspRARiVJVXS2+PiT
         gyBNLx/BiB1xRwJOuLVx6Mn8LFdx66Mo1/0vEO+Sy/VN8t2BD3cT1bDjegMKFNeYKils
         dPg+9k52obVRUr5axLB1t57zzFM07WxaxUGhLngS4fpqoYKKWNZYWrDEDKxWsd5tjH4J
         PLKA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/2l/zad9y+UIk+1hx5/zweDvLFrCe59zG8szP3wPYS33WvxPMcLu0HknB/MznwCWL33JPbSulhcQ6ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlCcSK8cwuNMbADrcPa7T1Znxxsk475yEJfPDB+RuXcc9I3Go
	8FLyV3G0Ib4tWXvdh3dx3k+Uy77zR/m0Gcj7rYMQZ9jzJk+cSBjXSemD
X-Gm-Gg: ASbGncvPOXdnpVSmWELnoLH9x/cr3UU3n9XEiUTVioIsQNgOPiCcte49ZEzCALtrsu7
	Qle2JnWSaAvgFeIIZjwmBaLBmtc+WMFbCN77+JRLYr8D1pFVPoF/fJjZdajNwgdqJTGs4PKVwFU
	JiLmSXhnJDEiOipc59WkKS9jbJ96RTLqB/XfzhuOhhLP1Lbkx/S4bH9FdEwDzCIopZIpVKbZABn
	QvAHAScnAII8nCH3l7wA6CZdGDS7hds9YH1/SG3qc12h5zVnjzrNXC+Xj8la9C1Ky76FTFd8kEk
	1xfA0UgWi+S815a9VkHvu+s5D4YmHkhvE7c6w+jJYS5dPF0VQS7HWV6+by8IxrL14lCJtXwPY1W
	tH+JhxHKupXZEOv2bsrmZImMd3fkp+UXh00cZWNHeFWsDKO+ylNGfJYcbE2ZGQQrgZzUSZkrAjw
	JuLBqEzVTWL2+IYxHm76mGiMlW1TYHmUcX/gaLe4g+AAeUkwnQXW38AO8GXJQQNGY=
X-Google-Smtp-Source: AGHT+IG8vD2A31Am91kKp86zcrwHM1GJNdLY6dWjx4cxR0fFQbBMXyptxdu0zGiFmrarnTn1sUpqAQ==
X-Received: by 2002:a05:6000:601:b0:429:d2a7:45a7 with SMTP id ffacd0b85a97d-429e32f4abcmr119842f8f.25.1762278044409;
        Tue, 04 Nov 2025 09:40:44 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm5622982f8f.45.2025.11.04.09.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 09:40:44 -0800 (PST)
Message-ID: <08951e84-24f4-4708-82e9-d23147d0c352@gmail.com>
Date: Tue, 4 Nov 2025 17:40:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: Fix double word in comments
To: Jakub Kicinski <kuba@kernel.org>, Bo Liu <liubo03@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20251029072131.17892-1-liubo03@inspur.com>
 <20251103162416.788bca9f@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251103162416.788bca9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2025 00:24, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 15:21:31 +0800 Bo Liu wrote:
>> Remove the repeated word "the" in comments.
>>
>> Signed-off-by: Bo Liu <liubo03@inspur.com>
> 
> If you're doing typo-style fixes please fix all of the problems in
> the file.

FWIW this file is automatically generated from definitions managed
 by the sfc firmware team, so typo fixes need to go to that upstream
 source or they will just be overwritten next time the file is
 regenerated.  (We have tweaked the script to add a comment at the
 top of the file explaining this, but we haven't pushed out a header
 regeneration patch since then so it's not there yet.)
If Liu does produce a comprehensive typo-fix patch, I will do the
 work to upstream the changes.  But it doesn't seem worth it for a
 single fix like this.

-ed

