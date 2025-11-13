Return-Path: <linux-kernel+bounces-898504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A51C556CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1423A878F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A982F6569;
	Thu, 13 Nov 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="jdMSb/pu"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4D29DB61
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000499; cv=none; b=Kni8/RY6FTHW6LizcwPjr356ODvLx+0YskK3o7kG6mHURkHHthGfduhQL4slHyzfoOSD/AoKoh6ZkA5Lte2y/6iADlvgqxvgsyk59APM7m3iVyK2WUVGRJV/BTYIBdKc+DFXhYPEeYPIt5aeP1sLiDCQXFkHt4hvpuWbIKY/W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000499; c=relaxed/simple;
	bh=JrYpJbnMMLzKJWCfIvJsV5n9ot3SXRyGAY8AhmxUdcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qKjv+zlhB08MvshKp23fUOLFiPPEj2cSMcDPLNWkV1LcdPBCVGgYRgCb43r5Z9TOQ1XG/EON9/tQScPtlqacOv3jHC0hTJrhxB2jQG2j7gJdYGmWzkwVOFVBDJ+hYwLmc4Zr+kAB2f3tz1HkxHrOTQsnFpb6er7NzpEP+u+OG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=jdMSb/pu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343ea89896eso298296a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1763000496; x=1763605296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XQUss227TbD117Y99UM8EdtGfgfeIJ7HRgtQsqQweZs=;
        b=jdMSb/pugxu3NC7BzKQuq1rNd9AHYhRZ7Ca877dmPO4ZxyUejTJ7xlDUFmCr6rPgQC
         OHU3rT+qvRa4YdwSYbUoxi1N8cGhWlttMzGRwJQ0okskxuz01JluGFMEUIy9nuOe3Nux
         ZAn4YOAH9LMhJDprjBr9Dlz0t/xUP+H0guGH9Alx0QAcho6vbNG75rUSES3RXRXdRnPG
         bzEDloDF5EhCLf56aJuaPakNmgm1pyIsOKe/vAkYora4IBKBJys8CxB8Vlgt1ASdNNEo
         J3GL9dg6+txkTKW125A7LkRL10TNmVbaKN/T9owi+yXDcEKObGuU8TQc7wCq6CE3DZ6M
         QoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000496; x=1763605296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQUss227TbD117Y99UM8EdtGfgfeIJ7HRgtQsqQweZs=;
        b=ao+7BTGi3LAbqHPJaGB2MWb0Rwpmrw/i2K8OOVHUVd1IZXLCrCq3wDQxiTtvMvF52o
         ehjrOhSThk8P//gAR9ze/VCxySEV4cb7vT05WgNBjDTk3276SrNtEFyQySN6RbyiV3ek
         GlMK+uiRBrHc63cTTYoN3KDpTo+E+ZYAAed3CkppCIE/qT0DINbTKD5XvDNJpsSImq5J
         ICZZPMxo/DBZLCnRrZ6COrwKcmCRFWI7IMEv+26djLKmFw2VOYfs97Sa3evm5kBZe+VJ
         sQ4zxShzBeqSe0VC3gKr71EZxtr0DOMVT/puWntwUs6DgnU4gp5F3qN15Qe0PhMYxsNN
         gEMA==
X-Forwarded-Encrypted: i=1; AJvYcCUi7CLXH8GP4XKKKBbhhnSDDmxM54jcfrukLDeaIpo3uNMSgfMAdWdht9MOhJtZs6KI3qXjPRn3WsaWnsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgrl/6oCIYkQRbXwWd1TtaDFB5yCe6Du2C6lcyox0TlNVaWyb
	qBmHM1I/6Ojruu+V9G34TBl9JN6p4DCEzl9RLWApzSc6wdm7/x+AfvgRsL2riBik4efp
X-Gm-Gg: ASbGncsphbXVulL/mwwh7ho97ZkDS482EFnOSynBK99I2MOCRVhlF1qL+Fn5aQJ+FUo
	12MaKPJxqdY9iom86Qsn/+4Wgp893k1U7EWs4n94R082GHbUyE3ZS/rUou3kyFaAlcyh8uZAxaZ
	9RL+Oki/82GyIoa3Ocd4EB3DfXie+VuccY1mrd1oikuq0+fYU7boqiDCYpcyyHvGWuj25bEj4Yl
	TQAvmFEOXsbh9vSJDcOXGObELFSZyTfoLCXGJmWLRHr7T6aaiRxpV/9bRfqxxjo1Y3dCablecG9
	rL7Tj3ntIntwiE/5f4buq567ZxNE7JYJE3mEanYlCKA6luAaHE1eyxH3XV105Suyk+rRGsFSSq6
	ipe0KfZwxDESAkcCSPT7e4Obuh5rUfMOKX0IhAs5eaNJIn0fhnITfDd0Rj3+90mxF+7tGoKhisy
	EpOIqqVzzFZVFLIx+oOrC2zVmuoTG1kQ==
X-Google-Smtp-Source: AGHT+IF7raoySsbUlfbW8T8R293TK8CZiEvhaipCZA3Z4lCexZrzcSnDUMp5q+957C2u5Z8dulGl+A==
X-Received: by 2002:a17:90a:e7d2:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-343ddeda0dcmr5440253a91.25.1763000496550;
        Wed, 12 Nov 2025 18:21:36 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eaca761fsm583707a91.2.2025.11.12.18.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:21:35 -0800 (PST)
Message-ID: <d919223e-7901-4b1d-bf53-69cd71ecec70@chenxiaosong.com>
Date: Thu, 13 Nov 2025 10:21:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: Re: [PATCH v5 12/14] smb: move FILE_SYSTEM_ATTRIBUTE_INFO to
 common/fscc.h
To: Namjae Jeon <linkinjeon@kernel.org>, chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251102073059.3681026-13-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_n3D=CC9DfVTak3oQa3xqkQ2jyHm9sUKDLd=exJAuXJQ@mail.gmail.com>
 <7f061d12-0166-46ff-be38-33f6acb02a49@chenxiaosong.com>
Content-Language: en-US
In-Reply-To: <7f061d12-0166-46ff-be38-33f6acb02a49@chenxiaosong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seems that the client side does not use FileSystemName[52], so I will 
try modifying it to use a flexible array.

Thanks,
ChenXiaoSong.

On 11/13/25 9:56 AM, ChenXiaoSong wrote:
> In the client-side code, SMB2_QFS_attr() needs to get the maximum and 
> minimum lengths of the FileFsAttributeInformation. Using a flexible 
> array would require more extensive changes.
> 
> Thanks,
> ChenXiaoSong.
> 
> On 11/13/25 9:23 AM, Namjae Jeon wrote:
>> Is there any reason why we can not use flex-array ?
>> Thanks.
> 


