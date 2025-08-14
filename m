Return-Path: <linux-kernel+bounces-768056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D404B25C63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAA179933
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C025C80D;
	Thu, 14 Aug 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfIe0DDX"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84F259C83
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154724; cv=none; b=n/LdTjDBboJ4XObrPIhltayB+Bk3Vba3Ndk1LUEwMXZH8miw5rann1eY9R9dbuE9YDc5LFKi4yg4M0T2bsIUyzZASNW4A/Syae08bnKoSVJj2SgkNYL5JakzSw6+bqk7z1S+ZIXnIMB5+eaqmkwIc+mGem9WkNjSpIbT08o6Ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154724; c=relaxed/simple;
	bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=ExVTCEZsFVGnq1Cvkda3mOM+72qdZtdElKxpPeJN7tV2fxLp9xUHB2260BDRUB7F5+uHvRTPduNlX34A58SExeGC+L5pOvC2Rkgspca+u8toxXOv0aI1DT8dGRkpLQMIIiPHxBPBur7m7OJpriOZ+GXRCZVCi7ZYisQyaZ1NcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfIe0DDX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso415437b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154722; x=1755759522; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
        b=QfIe0DDXcybkHXvXlURGcxaucrZ40tV0f/dutgcz1AisC7OsMAHBQaiZYQi1T5xhCv
         lHgBTo3yXtOTNScnIxIUPCfdY3CESPJlAx3o94Am4DSAOFrNQkjJEo09C6ixeNfU6gtZ
         w99QmILGRvvmwSXjLnskXk9Sr0Kii+Axn3IKGU02PDigPyAGbVubaeaqZKLsFjkQVbr4
         Sfz+GQZWpXxHjjxIhWXSiDq58dBO8xLsiexOOI0jha8tvw6VGQ32WrcooBnR4WCHlmVf
         Rkq8aqjZrjEyfCHDbMngZOHrWrx6EGyBrdnQzQ8Ws/cgKeQvhHM0oOMzrq7RY8jg95zH
         tpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154722; x=1755759522;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
        b=ZxkNTicaf+elqI2JXca48LnECzjrAimz0dOhTsGFzPu8V/4rODUXZGaNvjZJw0qZAE
         vIUr0QU9BfTSbmEMDs93h6pXlTBav983e+jEkRGqm9KTX38DApZ9OdDjWlme6HZG5J1Y
         OprbxkT2jGfP0pviyDdT9qgEyzQUa17NpnqWjQEBJK2sUv7PsSkhu4yfCxf0gSk69qp2
         1Vk7947dwSVzTsYGE0TloqijaA9njkyKuh68Mtq81FSSCDMFMfrZEQJfKGKXdu68vZ7F
         eA05C51lKp32JE7F6/wpgJ+sGMl88/So5D99rJvJhWFaULbG9R0rktAQMu/msBLbFhqq
         LXTw==
X-Gm-Message-State: AOJu0YwjjEtK6rSJlZvgVdqnZpckNQWwXB6/wRRBKEMvpLSz3BeHFM+f
	Cn4ESUT2dLTbP2v+FitkJQIxpdx9NMKiYAwAHPFFuXqqRgky4SPXGZm6pfAX4nu31QI=
X-Gm-Gg: ASbGncuIKx24humbKdQWh3RhgUo189Ja4X6Rxl5PAk8eiVsW88w9ifXMknS+cNWKMU9
	/XalwxGh52BBdTIuzD1WycFa/kOZUzrnM+cKM/HlkXaSQ6g1Rw5dltYvj3pSsVH2T3Y0UpfRZGx
	IpJzCpGfDI+3CfsDI3uWt9nhgbM1yt4nwIkuchNAOBZncNQzQEeDeiBvzguhSHGMN6S9P8Axwg3
	SjcSDjVEIR3pBsXTws9Sol1oN9LXeKo9fGo1MefY60Hdp235xAHjuwIp39b4pLyQu/tI7djf07F
	GLVRH2Ue/V1GqjLl1ddKEAcpceamOJOa1mEgSSpxbCRyEPFr1GHiVlOMXai606SMH1XtVeX9dlj
	N8ocwayqk/ODRHVaxsRxb8Z3u3skhSEg261z68WdWWXBWDvh3/veU
X-Google-Smtp-Source: AGHT+IEUbbHBtC9OOdyyl/y9a61jstg3pOGeRRPIw0GJ//TqLizLczvPBbrl607hq1GFimc0Baimig==
X-Received: by 2002:a17:902:f64d:b0:240:11be:4dd3 with SMTP id d9443c01a7336-244584afbedmr26009765ad.3.1755154722184;
        Wed, 13 Aug 2025 23:58:42 -0700 (PDT)
Received: from smtpclient.apple ([2602:feda:f129:68cf:a8eb:c94:76d5:7bd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2430b36056dsm43617515ad.42.2025.08.13.23.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:58:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: =?utf-8?B?56Wt5Luy?= <zhaizhong.ly@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 14 Aug 2025 14:58:28 +0800
Subject: unsubscribe
Message-Id: <55828ADB-8849-4267-97D5-09E69B4C085F@gmail.com>
To: linux-kernel@vger.kernel.org, linux-kernel+unsubscribe@vger.kernel.com
X-Mailer: iPad Mail (22E252)


Sent from my iPad

