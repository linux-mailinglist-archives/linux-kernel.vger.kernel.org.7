Return-Path: <linux-kernel+bounces-655940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA3ABDF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648C57A3A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174F26139C;
	Tue, 20 May 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parent-leaders-com.20230601.gappssmtp.com header.i=@parent-leaders-com.20230601.gappssmtp.com header.b="VdquZjwc"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42A2405FD
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756071; cv=none; b=iTj8sbCG/gM+eGxsSbvxcMd4tHKfoARRp4w5v33qRDSEsP+Egpk28l87gf6lCx0ffXbwqiRsKZKtCWolcWSKstMCBzToFhrSKI3qfpE/EuFBjdsp9zsX2vdwMvlwrZLLdVWkG6nOwq54fwB8mxOEv1vmcYM2YxHUOMzk5jEp1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756071; c=relaxed/simple;
	bh=c+NVbhKYnViiuhTIKv6ygPQwRWbXudY6EgAIzQ/rQKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UVbDD9u7xyEHdxXkyZfopSGlX/pUi4QLQztDL4FaH+w83uQ2/G0YDvGCwvNRIAY9R4DnGTxiSFxfcZ6EQY5lMGs3U+rA16zmZvTs6GTNMCR25/d3v2sIeRyVGfK/T8yBZItdSG05PjtDFkvKzTMsm4nUbjC//bUeZTXfHacE0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=parent-leaders.com; spf=none smtp.mailfrom=parent-leaders.com; dkim=pass (2048-bit key) header.d=parent-leaders-com.20230601.gappssmtp.com header.i=@parent-leaders-com.20230601.gappssmtp.com header.b=VdquZjwc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=parent-leaders.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=parent-leaders.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af908bb32fdso4517579a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=parent-leaders-com.20230601.gappssmtp.com; s=20230601; t=1747756068; x=1748360868; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+NVbhKYnViiuhTIKv6ygPQwRWbXudY6EgAIzQ/rQKo=;
        b=VdquZjwcB4Tzb7UHq4NhOSKkDCrik4OUWqgc2lFxpp576GLaamYD1zj5xnMRHO1xji
         a4AH98RE5KmKyd6fNWv3PrVnjFn9+anKjAQn+NIlavWIot8+Xn9bT6XXR1lk4HiVVMkr
         8AP41UfGr8Sh0Ylw/OSpaIih2wwJDad0zJXlAXdvb9ZJT3aUszXuBXBolAvDO8PJc8yB
         OzELNmucx6Qc9ZnvjcXvOHR6yOu4odbBsq7rRd5wjmd4QV/BhxvUJUh5oq9ld582mI2T
         vs+PSSTpI/cfc9YAPDE9Tf8b5KhVdbMYiYSq0N6R5gi+KH4yLKYvw8FGotAoAkMlLKPP
         EzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756068; x=1748360868;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+NVbhKYnViiuhTIKv6ygPQwRWbXudY6EgAIzQ/rQKo=;
        b=emcsRzIpgy1AvV41uPy9y7VuQ2P7IUzFaQF2e4DicoLstL6T+vvPtEPev8CHDTokDR
         Rmew5EoJ8seYXyPJj1Iyg/oKgZz4oYWInqoMgmjZPG02atnU/SIMg9W2BpQLI7hx+VPm
         rhpe9Ifr/UlpZZJjrwCPeuOKC1EFXYycPP0Oa3mjhtdg7n00aLxThcSvjwG47qEyxqL9
         9YqqtI8hbncRu7g/A/h+asBnmSL1u0wfmpCzZVjKJC6q//pH7vZlbRculp8IELNpQGbr
         HsdZalnCzObGtuw78qufea9/6vCcTQqnIC8x2chlyYXtG32jevvJmd3l5d+5vAyzNPX+
         XmWw==
X-Gm-Message-State: AOJu0Yy6gUvnP7y1OfPYoE/Hi4MKq7KEPYIvkYQeMThAa1STdxzp77wO
	C4dk9Au1dm2oOg8N9KBKbPS3BOI1ZaVI2G5PQHE0pfSbyen6PbJSaHlxk2YjOiYZpYlnW0jWsQ6
	Ly3IuZHXHDnMkKnpcw0TXTObbsD0LScPQLuYRX+i6ijtE0G56U6cc
X-Gm-Gg: ASbGnctsDEBE6LHkeaitRMS0AK64p0J/muKdL6kpwgdAOzO3qQskbBLWp4+Vrq81QAT
	QPyTNHF8PoINKrBNUjZ6YN1s6mZY5ch6lkO9QWyiynrlyV6TE3s+7wLJoaag9Dd9+zIY+vQZ2tL
	ZLWRIN5hiCXwf/b3cpbIswEh4q4g3WrHU6
X-Google-Smtp-Source: AGHT+IFYt2ToKhtDoKia2ylxk5h4xbvUf4Mwd8X3jOX7KNBcqDwQo6mJinnm0Ufp74njycABfEdHaPv3NmJrWPJLp+w=
X-Received: by 2002:a17:903:2986:b0:232:2b90:1410 with SMTP id
 d9443c01a7336-2322b901585mr141108945ad.10.1747756068176; Tue, 20 May 2025
 08:47:48 -0700 (PDT)
Received: from 402240868419 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 15:47:47 +0000
Received: from 402240868419 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 15:47:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jenna Sherman <info@parent-leaders.com>
Date: Tue, 20 May 2025 15:47:47 +0000
X-Gm-Features: AX0GCFuY5lOynijh38mOz0vwgBmyyiaNlo1d43HyjVMGqA4wKlDuky116IQHW6k
Message-ID: <CAETX--aDi52aWEv8G-f7t6yzJKPY-JX_0cF6i3POmoDQ1+bFvw@mail.gmail.com>
Subject: Follow-Up: Enhance Daily Energy and Focus
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I'm reaching out to see if you've had a chance to consider featuring
my guide on enhancing daily energy through simple habits. It could be
a valuable addition to your content strategy.

Best,
Jenna Sherman

