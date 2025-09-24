Return-Path: <linux-kernel+bounces-830469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6331B99BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0460C326564
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75130149E;
	Wed, 24 Sep 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdEaWwJG"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417F30275B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715284; cv=none; b=L5tna+w2eRweJmOc+ZqQbF0wE9KfC7WKZXUVNP2u3Mpd8PpGvnjNfXV7RHf9k8DRqDuU3PL48JuEnfTLPlTE+Y3Ma37Mw7RTiUpnlp7JRAZ9d6wRJHTtDwqvzvNXG7zdaO6uvgdPqKNUJATI9T0FN2tlh3dsYq3KVrG44pB6NIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715284; c=relaxed/simple;
	bh=56ADU/Huw4y50eyhOODiO2KxjxOtZZ2aVubmhU42CcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qptYN3i4ucnaU7HEQXL1lEUogi3tGynJbwy24e49Q+CDevK03h/ZZ9Aos/NiSp+//DR7Hwi9EOzkvo0rGIvk+1TW1xhy0Z5BkYQYkvhXKCtBzkHSrJh4MPge1QmrE8Y4gkqyqvCT/asB4wbSRA4PO6gTT/dIBraEOHjP7BFZQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdEaWwJG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-73b4e3d0756so57337787b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715278; x=1759320078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGVqKhEE+BMtFH8cMl1+mQUXbSkvGH7kkBhcJ3WHkpI=;
        b=UdEaWwJGyMF1XJhhdyEX42UC57qCxpWCMuYv3BKgvIbRgsprzIE4NHMAoEpg8aOnSg
         tLdbnyiMgaW4jzehjm1A6dPznGiAZKvreTgz1LeH65fD86r8//Ew7ZWX8Og/m6Plo+Ux
         78NNE5tOAQeA4ESxlVq2+vUq/wRCBm/uWBLhC634skyvpD2aisqCB/OoQOJeDbKXVtJv
         DQI//lxjONsQZQ6U1EwmSajdh246hmc07E9Z0rQO0c6c5EBzdZiN7cwSm/lY0QStsRPj
         7tBENE2WLdxi2NDZLEwcqln5Phf+1di/O3dFAWQobqGut/Qfq73tXxsUp7D1NpTeaTJp
         42WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715278; x=1759320078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGVqKhEE+BMtFH8cMl1+mQUXbSkvGH7kkBhcJ3WHkpI=;
        b=DI7zFvx+Ts8yAIveBwOzMBHCPbuq3jJgbAp5uhcof3OCylmxkElvUTxFK1N+zQlSRx
         KdOPcx3goYfqOJqPhB8+V4xaHcgZUbfwwi8y4xHA/XqZWO56CLWPKnDST2mtMTbR2Hrn
         y4+bsnAL1Qra0mvW6+i+ffdmM6wCCQMoqo0Bse3dk7WzxmCC/7flAxg5rHdXOhL6Ypu4
         gt299rmgx15uFfe5pZjohvE1I0N7MuIsZR5f5dqgoDxM/gQEmymNdbPc8pOxFgV58W6o
         jZMKyOoK6qnX9WpUCLOr1BaJnr+PHO4Ym/mBjhOF6Bko11i5+5wsWoitCBZCKqXM1lls
         mbrw==
X-Gm-Message-State: AOJu0YwqX7O+8rUjsaGckWNXYnSnHji2NqTil2+CFnFnSK3YetZscKnH
	N5VnviCy9AvMG/y6M2QsC7rC8SxAC2pNpdJIT06aNin9PWceR+2UGV58TFT2pTX2Zxk+r0hQDJn
	VMkUobwV0yWGvmntX9t//Axu865M6f9s=
X-Gm-Gg: ASbGnctXGAQHobluL/b7arcJ7IfWePjECuisZZDIYtK12iswqp/g5uwkHb3Cuz9ByiT
	ynZnjnNkJXJKsfurwguCr8tkvDKgBDsqYSfn3VxULWPy/ST0U7GUPAwgRZx5vXN23+aiukEP2at
	wKylHRd6JrI5I1zkeFZdG6rN+uhhEKBFydLzwnQ+G/qk43vZ+hP/3Qdq4+p919SK05eCz7pznwn
	pi+dZDSoepItb3H
X-Google-Smtp-Source: AGHT+IFdBM117VVOYGK90475Oc9X0RPGZs9aXyBHkSYL5pNl1nbRTk4X8rR+GskXSt8yyA0SxJH8Es0QDHvgzR/KM5I=
X-Received: by 2002:a05:690c:64c7:b0:728:ec0b:bfe9 with SMTP id
 00721157ae682-758a2d01e0cmr42373017b3.28.1758715277707; Wed, 24 Sep 2025
 05:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUm4M2HTQuO7ORXVE4tScuSTjhjeAVek-7JTBgb9i3wrQ@mail.gmail.com>
 <CAFRLqsVNSj=MCNWVsoXA335LAhvz=oELZi8kg+yFnwWW9A3jrg@mail.gmail.com>
In-Reply-To: <CAFRLqsVNSj=MCNWVsoXA335LAhvz=oELZi8kg+yFnwWW9A3jrg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 24 Sep 2025 20:01:06 +0800
X-Gm-Features: AS18NWBkHXOfpyMQ7UyFRfVmdEHP0oHP_6EggeaZRosVlhLhuwIYwc4LfxoPOVE
Message-ID: <CAFRLqsWNtG5pMC+9_HeFSO0uqB4z4a2Eej+rVHAF3EUKcG0U=w@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: hci_sync: Fix race in hci_cmd_sync_dequeue_once
 causing list corruption GPF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I have send a new  bug report:
https://lore.kernel.org/linux-bluetooth/CAFRLqsVv0R282+xQE4sRM+Tkb0=J_s4Xi0N0K2Cvz++T9fHAPw@mail.gmail.com/T/#u
Sorry again for the noise, and thanks for your patience.

Best regards,
Cen Zhang

