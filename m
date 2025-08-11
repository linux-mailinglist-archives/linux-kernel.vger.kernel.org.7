Return-Path: <linux-kernel+bounces-763408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C57B2143A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F183E31BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542C62E2F1A;
	Mon, 11 Aug 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuWt6+UK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2862E2DE9;
	Mon, 11 Aug 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936428; cv=none; b=p6ZlSVnwmoxwNYL9q/cM/V3+Hkn7sVzMVsnVZ9ixhgGWIgxyx+oqMTKi9NIKGQxSvSwt8wm/z0rB40Ah7Odt2xnAI9tvWbURCe1679NIF99ymUMkczHD5xXnGb9tVMauXMNpcStWkSGj80fdMzgimcSf9I99MedUH6ZC69E8mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936428; c=relaxed/simple;
	bh=j4Z7I48pgUVtT1N8DvipQ/LEVf5M33eHpNoPnJ4KmCk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gM1lSN3elSldkwjbTkcRDn5LO4GWkPShhFDG3vg6DPwTP0mcO8MSt2agDoRc5gpFUyVgNPzozDdApmalvS0/jSuqW2D4uUOD2USpqjiQGBPjjy5stjqvwDZjhXn7riASw8POY80WnU5N8ZPqmI/1HvIeWvpokowDBTf4X8OgHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuWt6+UK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso4056353b3a.1;
        Mon, 11 Aug 2025 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936426; x=1755541226; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GimiQk31QxHr3PFh4m9HMVZ9bJCvV7EJFcpqqkOaSaI=;
        b=kuWt6+UKM0yJGWYTAAtueYZHkIbidEf+hKsEEIpymcFB67/6aP2Xv0jypmdf2B/8Xm
         tjl5oXtSu+/aFBlx8dEDJWS7rkEOi/CpdFjqZ/RiGek1QTcMQf0ij8XWaAx0W/dabNOM
         vHgbRPJp4zLn1VrM+Wis1rW90P1bCG0XHeJeH26HIVN6zk8yNWEwk+11DpHwbbrLPbE8
         530MwMy3FNuG0djIspaHsejHVj7Gw4EY2DamfccTH2UDAx5reTYcim/arah4BSRpv/nw
         Q9tLoa+f3fryYesyNbS+OS8TqIDjf/yJ7OYjG/crzUH0JBIAOgVo9tMgNJ7l5O562489
         FfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936426; x=1755541226;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GimiQk31QxHr3PFh4m9HMVZ9bJCvV7EJFcpqqkOaSaI=;
        b=QuzYoyshFzWjDWhflhJKDnq+k4d7FQzzbQ6TiNuA1DvA787KrOMgvUiQuxoThEi+hD
         x83w4CZBfIVNorH2Ns2HREJ8b+ZPf1WEdtpD8SjuRAfZJ/AsELJo+WH3lun9Z9wvZIrx
         PtOT++Cwx7awIOBO0hTT4gt3gL1sDAgNXXGi0q/xWfihsXcnzarMS1VxsNLUTq1A55RO
         IGgKAAsTUuM4zaN63KkEHeD/lJheWC0YHkFlyBvZ/1o0g9H/F/eyvyJQbXY8g7rE4PLS
         UMYdIrfNOF/rDRWCdpKKtV/UqwkKCaxXskBtIBjT/jPEhCNP7Jr39mKNBSSFOhrLmm8m
         MjUQ==
X-Gm-Message-State: AOJu0YzKyHO7RGNhXtIP+vIXJXtNROv19yCvxNTVZ0jSbLaryNqCVPAW
	ySLOFWBLxDZeWx1QyQ+UuQJTbv0xRyINXIcDejUrZBKEZCW6ZoFCpvleAIGLyTFm
X-Gm-Gg: ASbGncswyB1ARTQTUA1s36EAz7/XvtMPsGLY6dd0j1Qc9X49be1Zam9k4qXNWIiI85B
	kTP7aaROiVSDSxrI15qRSpusMYSPZhuNatxoX8V24cN4gZ06mru8AFOiJkgnD66WK4F36mZbSGl
	q3wG0HaP10mZyvshGWSGeGggOdozJevwNTd95nwZiOlPhna70kk9uVw/3s26qcXcUwJhwtdhyWd
	tzjywmyfSG8wp29c2iYFnbekxgumxyUyE1cvN4Odh/CiN3dOlA582D2DaW5axthTN9YGPzRUP6K
	LOKuv/wH1zm7C4bzMJMDxmD79U6lhOBEMkbLzgj39Y7dWlQFuADASaFbUUDNBBJlb6+ACLKWQe2
	lj8TpvCpM34qFL4Jlbbj8/E3vW8hRUt8uL/mkzRpOKYTY2YFp12T19jo5weGu/4Y2v6OTGWqN
X-Google-Smtp-Source: AGHT+IEBXqamYJpr2XWIjcnZ+itsOP/Q1FW3WxO2G/PduGQvEMRbFWwn3lXt4+JZJCtjNwaP9TIcNg==
X-Received: by 2002:a05:6a20:7494:b0:240:198:7790 with SMTP id adf61e73a8af0-2409a8be3a9mr712164637.10.1754936426305;
        Mon, 11 Aug 2025 11:20:26 -0700 (PDT)
Received: from ?IPV6:2804:14c:de86:8d34:add1:b1bb:ed29:6539? ([2804:14c:de86:8d34:add1:b1bb:ed29:6539])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b642931sm23622862a12.0.2025.08.11.11.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:20:25 -0700 (PDT)
Message-ID: <79821f85-9e95-4426-8b1f-8752f8683dc9@gmail.com>
Date: Mon, 11 Aug 2025 15:20:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: AI Talking about AI <aitalkingai@gmail.com>
Subject: [PATCH v3 0/2] Rust: kernel patch series
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This is a two-patch series for the Rust-for-Linux tree:

  1) rust: mark CStr::to_str #[must_use] and update docs
     - Adds an "# Errors" section explaining UTF-8 failure modes
     - Prevents silent ignores by marking to_str() as #[must_use]
     - Documents safety preconditions on as_str_unchecked()

  2) rust: clarify safety comments in workqueue.rs
     - Replaces generic SAFETY: TODO with detailed invariants
       for RawWorkItem::__enqueue and WorkItemPointer::run

Please let me know if you’d like any tweaks.

Thanks,
—AI talking about AI

