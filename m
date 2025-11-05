Return-Path: <linux-kernel+bounces-886631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E0C361D8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D354C1889418
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE73328F2;
	Wed,  5 Nov 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYqnVyTZ"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664C331A7F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353618; cv=none; b=EWDLRy3gt4tU6xXD/rVh2lXu6Sft/diz59cx9lDHJJUAb91Flu5ZX6tat/J5lL0N8nYDYf/2Zf+Xa+t3is6HsqissudgyKUoKkJ4czzegVrDQfERi1zjh+PATRiXuP18JqkzTB9mA+sb2kD+xO7orXwITlB1TupzljRO8BZwAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353618; c=relaxed/simple;
	bh=Y/lXGHe+gqUlpxT/2a3TjBagE2nj98BAgLlMkCD7yn0=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=XP9zPXQCW4UDazk/bOIgein+VOMi6nVNn1mBqjR6yZDLTmcO5/EHiLJ8cK+1hjY07jRSi8l139siFkcdCaimRCdn0KFhRJm/MY5OFm8AL8Yazc6afrnWSGLPloZqekLCw/09ug4pcdOBqDYGm5aSTDpn0SXfWYKf7grh9QzAat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYqnVyTZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-330b4739538so6671341a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353616; x=1762958416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIHawX58BbfIVMXiDfSeiVcNH6WdARDGxAqamzICfAY=;
        b=WYqnVyTZciwYDUG/6x0LrKqz6+sx1H0hwTLPhVTQ9QEQImumRcQdV/b/XgbTBRynSI
         hqKjmd0gVnz3FSUbAe/steBMdcB5FZS3SOPP4WuRpsxSPmnVUUcnnI6by7CUDKbymgHi
         /P/aiqr3saG1hd6J8c7Oys3sFB6L483B7m+QZG5LSn26/VnOwS1OO4LwQQChRbHOQPgN
         hd5gy2UBSXBRBrwtl3fh4huwBeygAw2M0w6KstYNuTQjl46qw/Q+q79JP8i07xiAqWr7
         4DSmWTOFv8IKRZ2In261wB4R5oZH6mcfbSc+LV6HabtXWcCKIR/Er17yM8M/H76qeNPH
         fBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353616; x=1762958416;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIHawX58BbfIVMXiDfSeiVcNH6WdARDGxAqamzICfAY=;
        b=b/RyA5oY/pTJLBnmed41j4YcTn5zsLx00DEokutrVPDl0SfJqYhEUVw9OAYKT+g5z6
         mzgq4rUKWvMpuRb4jWy3prsN8OHtiLY2FCN5ZunsiwoOS4AoTWNRlQB4wXsaxPjRgJ53
         N66Om0jxFJaNmySmbuxr54espUSx/iTPZLlW60Ww5BFUnw9B3vR+0xS5PrvsE+EXWxXh
         bEhKUqqS45m9A5edZipOeuMnGBFWLi8y/71IuY2aac6dTz3TKgaeZW42Rn3ErB7WYv7y
         EoY18gyoyKA7R5ufRMLswktymBkTeA60iX9AJMsuXYDgHMbxkc5rP5qtUcGrneCEA7AY
         dYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJLIfazJ95cOy2OL5R0x+UNpomwWu27lA03m+2geQ8Se6Y4Br+ZJ1/kFEm6JJayL7sR8GciqbH/r8FY7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgWr9eo7vTiOmmwgSOzJi/aItKiQtTA9UQM6vtEgPo7OYb7Aa
	TUir77O2ilgECYjBSvh2jBM2c9hysyta661GxOcIcClYel/6Pyli7bBI
X-Gm-Gg: ASbGncusNiPSKoqNOlKx2sJg0P+CorwLg0yrjtLipthKGj+T7cBuVM/IDukyTdgvhdY
	UvDBKmmLUuyhEXyamVi3NHQvf8nI2LY7XNEQ7/rsQLxt1OiZezTSlp246OElzDrUWQRu6PT18Y6
	ksQQlmZ8sWOK0nFDpjcWHpC22KWSArs0a2MNdCtfESi0g3IZldbdeu2rFSTWZmBTICYU7vIgtHE
	QlzwoyZeViS2fUNnopxMF0mCd4lmraXMB20FmRenc1TeG0/pFvSJ+YAiG2ITzidTXH4+sd+yZvf
	38KPYokF+vfJP/QeaEj8s8wgCPs+6c8qzVyLxNPqPQpcS0Q8kb7l3QFJ/wxq9QTYiPTRHG0ikho
	QRHtlTRIZH4EhBLgV/MX7t06VXezwOujpYkD6q0B+XUi2jseqYV6q7Jdh82MiByIOuZKhvckzdV
	uoPCAgC50fGSU=
X-Google-Smtp-Source: AGHT+IFiVvhf3hLDjIqWbHqpdiOoG6ANOIt+yMe1ih3sPzpT24zI2pgxC199608O4JP4BZYtMwrW4g==
X-Received: by 2002:a17:90b:4c49:b0:340:c261:f9db with SMTP id 98e67ed59e1d1-341a6c43e0bmr3903319a91.10.1762353615512;
        Wed, 05 Nov 2025 06:40:15 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b626csm3187039a91.19.2025.11.05.06.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 06:40:15 -0800 (PST)
From: shaurya <ssranevjti@gmail.com>
X-Google-Original-From: shaurya <ssrane_b23@ee.vjti.ac.in>
Message-ID: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Date: Wed, 5 Nov 2025 20:10:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org,
 syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
References: <20251105142251.101852-1-ssranevjti@gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
Content-Language: en-US
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master


