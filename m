Return-Path: <linux-kernel+bounces-813711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC8B549D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BA5580637
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94F2EA16D;
	Fri, 12 Sep 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2W3MMmvF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5B2E8B6C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672913; cv=none; b=H3tkae4ruuGzhBuuqJVTwGNFKA604+y5oNQkMe8qbTOjlxeg8rMQWN8q16rT3Kkyki7977cxy24lvtu6TFbPVVaiwzDTqI07U9/YkiVGtzYlkUcNlB/zQwqU0wfmOTgU3Iz7PeqGX4W681QmSwWtcZS5xR+PJokDAcmUkJmqfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672913; c=relaxed/simple;
	bh=22VN1Nog80BwtvrES1R6qAU8hOqcLI3BDqyb1tefays=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mN4yKb9+8D5eaE0YWFGeZwN5mrccQmIU4GIMgp+eG2EknDKMmPr78uZUPoGNAI6/jUuV4nU1xvLJHvQaZD0kn3wENhe+SdvhgbsYNNYxN7SFwurTsbfnuXv9bqF2/b/YYqoSfCpVpYC1aBp3pVn3TZ74Y7fB/9AtHJPE7wrULWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2W3MMmvF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so330303266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757672908; x=1758277708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1W8e5Qc2+Xnj6Q1VrtcQMEhANJj2cj3Yc/6wvc5KTkk=;
        b=2W3MMmvFpQJqzdt++pspweQjbAhkYZb33WFS9qpiXEu6qlPde2fExSbX6HFE7c9X6l
         qWX8KBxsUSFv1ZlbjXejJY7AEHoYpaMzKPWbSkfJtlfKUMbSKnoljwqfUxSfecdw8B8P
         UVuOJeVxEi7tAF3la2QN7F7gJUdRWXxLVlwVuqlLpCSKW9YkLgJGhPhkPVm/Mptt/70I
         gTtYKAWnPm/3f9W+eKvAOaKdXh0nvFsShk6kC9fFYDCvq3k8qJAGZ+i4KmC+Zbmr0JHI
         Jbewmz4lhXLdnkbhDmv4xyduKtzWhdp6WjCqKlbZBWWHpGD1VPxYMewgJ4teUVaNu95z
         3yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672908; x=1758277708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W8e5Qc2+Xnj6Q1VrtcQMEhANJj2cj3Yc/6wvc5KTkk=;
        b=ZjLFVmTqv+ZraKtECv5TLLzJyY1q5wVPRBeNfKEWmM41c8NfAiyayY3IaZBHU4p8Ay
         FdsRC4Xas4aaETH18vCccA1I9DxNlJsgNrxog64deW059TkwkrtFXWr0Zx+nrsMie23G
         /L8Cz5Ac3iq/hNRoIG9kzwx9DAjD/i5DZ6WCpw1Yb86tkvR2rK/dwOWOMvpnnifuFOH0
         hxNDTs020CIMAChu6HMl44fKo6KxyayTZ79smvj3kVcT8nME3LOSfP46V7aJnTCQNejM
         DMNvxzZwXNgGMv9lGyAFXRAfWFpktV2zmwAgC2e0hrweEvV3iJ8/kN8PGY58XzHX/6fM
         fq4A==
X-Gm-Message-State: AOJu0YxeNynPoV507wU0M/aq7l+GGi0u1x10p4ihNICE3TnYGpbt8mdR
	CN+aB1/5qtkqUjKY4DCaELcO7OCT3U0Cf1eNpYUUM3y6s0yVg01ZrA34rG22KuWV64U=
X-Gm-Gg: ASbGnct/3qAEeYTc9Ne4AB5ElMBxIewFftboizL4D0UmMUpVilEb2f++Ee67o4sA00p
	rNQhdXU0N6TVGGI4RP+LPcBV7Mf3ycR25jYzxTPZ2IYbFucs2/P9NxExpurJq+GSXbiuH/eMp2o
	mf2KJZwJPyECl8eQcH+DrsJid0FQoqGH8gAl8tfeCOYAKVT+IHYsGmnmbIZuW57UhhyaNlzZdnL
	1woP8rCTe151jQN4exdUAK+NBif+Lomnfc/heFIjnRlSbea6mvsxo0OFZ1/4vVNw0U/VEzqh+Re
	zmt8wPbPpKmpJ1IktOQcaBQsvp9buiRZnT/2NcjFsFv/K/p+UFOBxtSUJOvojPhrbcvv7glAILU
	5ScjObuOC7XCZlUj+9dRMEGhrLM7xSo5nzpIca3csCyozsZ6ULb9nYYLHinMb4nTcOew7dod/ic
	k=
X-Google-Smtp-Source: AGHT+IEVkfE3+OIQV7+ym3yW7Mjz5Gl8HDjI9rfeitZmA510HeG4xfhmcK8YxYdaDYb2TAtLmehlkA==
X-Received: by 2002:a17:907:25c3:b0:b04:83af:b4ba with SMTP id a640c23a62f3a-b07c3a7668fmr238021366b.52.1757672908258;
        Fri, 12 Sep 2025 03:28:28 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f1edasm351368066b.89.2025.09.12.03.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:28:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] stddef: Simplify TRAILING_OVERLAP() and improve docs
Date: Fri, 12 Sep 2025 12:28:00 +0200
Message-ID: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=22VN1Nog80BwtvrES1R6qAU8hOqcLI3BDqyb1tefays=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBow/WydnMssDJxf3PoW3NatKlaCsuUSzmqM3iYt bzbZcKMOAqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaMP1sgAKCRCPgPtYfRL+ TlLpB/9NNVV4zlGfv0G7EWGWxkmRiWddhK/nviOlOTYt9fjawGeKq2vyL4oaptlA5+19k5oTnzd 63UY/diw3YebbIKqoT4f7JvjGdR3I03s2VnxkYM5CNRyhS/vv9Be123ZZFXGeX1xu6Trd3fANzu 096JE/ysoVEIIakLwBjcwz1cr1hGvm38Zen5ZqKsDk9+iFb9+0A07z6bkZU0M2TTbEA2SFxANeH dmmaPQyLbN0ZAqfDfKbTAHigkAw7/e90hblY3rMp9wh6SvyOrcZZhdlHpeUoSVNNZaUMuL9EVSi 96tS/Pcow0G067kAPPqh8J9HTXKybNRBaMxIA1RpwY8Z2UBR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

as a follup to the discussion I had with Gustavo in reply to
https://lore.kernel.org/linux-pwm/aJtRPZpc-Lv-C6zD@kspp here comes my
suggestion to improve TRAILING_OVERLAP() for wider audience.

While working at it, I wonder if __packed should also better be part of the
macro to ensure that


	struct myfamstruct {
		char c;
		char payload[];
	};

	TRAILING_OVERLAP(struct myfamstruct, mfs, payload,
		unsigned int payload_as_int;
	) fs;

does the right thing. This however is orthogonal and better discussed
separately from this patch set.

Best regards
Uwe

Uwe Kleine-König (2):
  stddef: Add a comment about why TRAILING_OVERLAP() exists
  stddef: Stop using FAM parameter of TRAILING_OVERLAP()

 include/linux/stddef.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


