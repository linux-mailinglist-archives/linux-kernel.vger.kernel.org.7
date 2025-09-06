Return-Path: <linux-kernel+bounces-804212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDDB46CE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41631B21DAF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127E2877F7;
	Sat,  6 Sep 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDrXpRtD"
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801C2765C1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161941; cv=none; b=ePaO7k49ge0lhziceZRYLExGiGjQQ9QlXGDxhU2icTMjrt9Xbppz5UF9lJj2ZrHwvxTm9jpwUQahYLxFdhmibCarc7SlgeL6AKOE3cJKNlEMJERxVLr4TYyUCFVBK+E8V1yEhDAht+8TI3ZrO1YYHgGo5ZyHbu7FxCerBhrj4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161941; c=relaxed/simple;
	bh=izpFhy2IS1ihYK66gia9lTGlw0Wot1gG1vn0veg3RGI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FkxqlJcoMNEztqdXfdbo1AoZjVVr2XzJG/tyYMHVDDiJaAHzSmCR4ywFij/yQeA3crO0pyJE7rDvLm9Qhpt04GdrFihS3oZFI4gyUcr7s8CxEoGXk4QGgBqJ228O/OMH9lrO1kfsl6curJQviZTKvwtwAgE4rMmnyFF/RmQaTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDrXpRtD; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-74382025891so2522894a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757161938; x=1757766738; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TV1cj5e+m7ZlNyfSeqpx0ybLwS0LgQF935pLx1Np7I=;
        b=jDrXpRtDNPRorqemH2AJ6Or/UVPBg01sAjsFXFPynGejtI4uI5/ONzoF3RuVF6UzBY
         IP1/CBsXx3c/zu0sI5IoGOJjaH8tNkmtILUe1wamMHXk6+rCrmpa6VDpnLjtIWpbXIod
         A3/5NzgbhqO32CoAoboF54R8kuJ/kYdX65XXh1X1MaPIcBNqRDG3l+QfdsP9f0SbQWwO
         oxBK0OZhzGfhw8aeFwb5RzrQIvQcq+nzK3XfDLG9tjuwSl5Rs1hGbwLqQWRMoVAquwyh
         VYPePqPdTIRRO3W4vWwADTUmICFe5tA9muTjEkhKkPWe7DCOYe/Kerr1Gg8yo8A6J3y7
         WygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757161938; x=1757766738;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TV1cj5e+m7ZlNyfSeqpx0ybLwS0LgQF935pLx1Np7I=;
        b=cVJmeK/tA1Tj10L4xi6e+TWLeXdMBfK6z2Y9/EHBBZJ1qsOpDN5nWi0+YbnFcPtYx5
         zXR5+3h2gLTYgHSZdKvDNY06FLYcFKi1V51hRf4j+MrhyVFcugjNwzzE5HAYcNkX+EUc
         7CX5I0+BXLM/zsV/JZmriFAzKv05Jaf2rhb4mgvNeC/f6dCzKdhJMgVZOJwQUWqqoMRW
         YjCZrVimC+EYRP0LoAencLtaLHUHw6SpfbW5BY9SE2U3HvBMmbefZUFsmFrJJXg98GF9
         8VFWbAuSNmPpHSAVwkZ7skDg0zpHEeJRNHnjKGTCHEue7BovIKzY6frnL/9Fr5qc1tUI
         WMOA==
X-Gm-Message-State: AOJu0YyPjhzPD2gsZpNLqhQ3U++K/YaPHkOAvGO8HZ97if3gK8kgFITW
	WRqiPr+Zm/8OGaTIjROJIupHpky6HG1uTj5nrBOOinEyAa0TFwczZmunogVHd6AtK44=
X-Gm-Gg: ASbGncvd+E+S+bvyo6xL1UF/co8s3m/pVU4SqP4WLdo++spAJBzMGw0akEbzqgk7qZM
	s0ODzGt8Qqy/rpcQnenlazAYDkbtzH2g2JeLwOIosShimdUF/3TT2rZUdOym7vYMoXJbd6+APoG
	gy1/feeU4fx+wI1QsTzofIHtHJh/Vd+CLn3JRL5Ys7YzTlTzrggq9Uj7fH9cagXWnkeCmv8TZ5O
	LdE6XV6WOr9VM8ZjH5xKNyMCCNN2W+PargR5E+ZjWKYEoHJijd/+VJaCglUu7AGYUFfj88E4dAs
	hEaBM/D+FW3wZ6+jGpoTeJe52HOl5dOJ6/7AvyiQA2C1j+35U56DYDoXt+4wytsmYSME86lMZGt
	ljvEoposN1OwJYrhER8JUDEpjZp3Gycg9h6jNKG5fMox6arNYpWc=
X-Google-Smtp-Source: AGHT+IGahccL7BTV7kHxAIiaEnxuHf0Q3of4Mfw4Wnd+xRlFixUUOhfR7tLzWoKFbj7sHbCaW9JpVg==
X-Received: by 2002:a05:6830:6603:b0:745:9d36:4841 with SMTP id 46e09a7af769-74c768f993bmr1146457a34.19.1757161938453;
        Sat, 06 Sep 2025 05:32:18 -0700 (PDT)
Received: from [192.168.1.7] ([177.30.83.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74a158941bdsm947194a34.2.2025.09.06.05.32.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 05:32:17 -0700 (PDT)
Message-ID: <cce59d13-e8ac-4573-b0ff-4f211eba07ce@gmail.com>
Date: Sat, 6 Sep 2025 09:32:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Vinicius Marques <viniciusmarkar@gmail.com>
Subject: Real-time Linux Analysis tool
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm using Google Translation; please bear with the team if anything is a 
little out of context in this email.

Hello, my name is Vinicius. I'm studying the Linux Kernel documentation 
and am now in the Rtla section. I started reading about this tool, and 
from the very beginning, I decided to put its usefulness into practice. 
On my first attempt using the Rtla osnoise command on my computer via 
the terminal, I could clearly see it in action. The point and the reason 
for being here now is to be able to initiate contact with you here and 
share important facts about the practical use of this Rtla tool in the 
daily life of an average user like myself. I decided to open this 
connection with you here through this email. When I first put Rtla into 
practice using Rtla osnoise, my computer started experiencing small, 
repetitive and constant crashes, making it very difficult for me to 
manage computing resources and continue using the Rtla tool. The core of 
this report is that my intention is to pass on this knowledge to the 
Rtla technical team. Why is this report important? This report is 
important because the Rtla technical team can begin to gain a more 
comprehensive understanding of the use of this fantastic Rtla tool in 
the practical field of the average user and also in organizations and 
companies. The central question here is: what can be done to reduce the 
impact of minor crashes caused by the use of Rtla? I am available to 
interact with the team. I wish the entire team a great work day. Thank 
you for receiving this email. I await your response and I am rooting for 
the team. Thank you.


