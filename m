Return-Path: <linux-kernel+bounces-875816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FBC19E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B957567FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7F2FA0ED;
	Wed, 29 Oct 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HFb/Lsp4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A82D47FD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734748; cv=none; b=AyUsia98lEf6T986+qzdT2r4N8g3K5OmyfyRl/EZM+PsCKay5cYPf7C7hk52ug6WZSacS4NGfvkL5zK1l8avv/5kXf5WSOssH8E2jgCHoWTNjPKArc/ZLKSqKoBXtLcoC19K/xOCApjybzc6+nA/e/oA7cFp8Lk5UADF0FpZxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734748; c=relaxed/simple;
	bh=0tyHkxDgHNgvSmrogo42iKYjIzo7rgV6g6hOBIWoz3c=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itL3rYIvjxZyNqM9ftoAmWYnQwHNd6eohQbTsBR6pWjMWEYm1J/pcuq4PDePf7fRl2q+NCHRtYW/JvUzLpHbUGNyfH/m0hPQ6etd81ZOLsd4K05f8z22wGaFUz0IiX3+ETjurpDPE+BCrOF7EHr/k33XEDDesmNqvkP334gU6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HFb/Lsp4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 363863F6E8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761734745;
	bh=0tyHkxDgHNgvSmrogo42iKYjIzo7rgV6g6hOBIWoz3c=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HFb/Lsp4LqRqC2XSWPGYnE6Y8ySIUGDWrcyoxT5adktWHUalgS6LbW9+1a99dhCIb
	 vb6ppz1hnBmBLtNzmjorT4Fl7nXCB1xto7F378NX5WZduo6NtEg9AZhV8Z+ZcDnJ1v
	 hwyXtPWHlrhCQMVMSDG8Rc9VPf5phYPUO5Nq1jPvMgudaIIP70sQXnlg3C44wFOSMv
	 PX44tuz9vVAKlnGp+e2kQwPaDTMn8sN2XP3GPeMCLOuXjXNDG0HrsxDBDgGTNvsoxW
	 cy/PJxyyWBUVtRvfnN2WHoL6iHg0WWVztsMwA/j+rfNMZXgspSp3Y4rUG/ft9m0ItG
	 mqWgyXjDuU9gIlLo1f0v630RbajClZMgfylz3AEWiZXjHMQigZPkfzvGj4AGAcSB49
	 h167cKv0i2OAocXT5uPHAJyeBrl4dcH5KOSNgjFbHdsBCdztUOON7rr3En5Focyrj+
	 xHCkQNEU52X1ikzKE1wnvhD7pvnwqVsFBfm2Ux7PmY9wnBZPd9dZIEQUYX67u3mJmW
	 fJ8HcqI8J9Kxn3i47l5YXBwcPjxIz6nNWzyO7ndodJVi8D6R5dxHvuQ3P1Tgh2HESn
	 OT7yKrPOEa+vw8Xq8L0h7q0QIGwveCXkmXxYJ33q4MMlxj/JLhihdsvuLHaoxFeTr6
	 sgZ3+LWsVQttdRVKZfJQYVPQ=
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db21e347d4so16076836137.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734743; x=1762339543;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tyHkxDgHNgvSmrogo42iKYjIzo7rgV6g6hOBIWoz3c=;
        b=ltAZ+xt1Je/DAmOmOuBS+8UBsynfe86vQK0Z04eQxz/E16h0hgBjZXt7c7pGCNBCyz
         6g7Hz+VFBIabSeX0HNVa72Ogq31RlvaUJODgLNoCig3SdaISw38WrW88gQ33AyLGDcpv
         cvTy4tZTfiI8/+AQyBpdSFqBDA8OoNWvyeCl6NiR+cr8r5Ewoholy3HsuE07PlUIzVR0
         kFsPjP/HKZzpRjfYNiludzV2i5SYIiQmrFlHigbqSY6NJs3vs00vzwfgL+MYfEb8Mwtw
         +sW66Y/PSvnAV+XRo0YVL+T8Ts3K2Zv1i4Pkg5jGju2kJuu2EIrOb8ICUmr/+/ous8eb
         ySsw==
X-Forwarded-Encrypted: i=1; AJvYcCXivzU0wA/Cw7Pga8JC1/In/xRxYaMSItBan8BCvGqqryzkkmxuRzHVBEc1sfn0SJr0gXp7DszsNVzsSz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzugWDw9k7OTYJuRF5qf54Gs8GXMUjYEOHLvjDcD+MznCIKkiRc
	Z2/JVRrOecF6/nmBxIggUbqfIJwVRf0OgbBmHXsj3uvFN20WsAhLfwTUsv9KML7DLiWo0cT7Vx3
	MxgbkqEWzS1pjHmo09qK1KJKAVinHq+nbMeP6oFODzg2qQ7Zba26Gk9qD615NOmlUT/xGKTXQjx
	d/d/ax0N2jvM+/ruBWnYN0VxLFOT5D0QLWcoRCQgqGLGVrhkqz0LJMxiPz
X-Gm-Gg: ASbGncts9ZMO4HrF9AughWsn4SuIHHrQJQO9O7pFWZ6+uXdGjNLeq3YJkMDCLgh+6b6
	ggzgZvkl8/Rhvm6QPEJ0R2PizyECGueCg4KI22fJq06iqMcbgWSga9ba7D1BI8tS6mlnK02GIpH
	hx6GNgiavQQiAKVYc+LrnoFpLAPRplzlLczObfqldjIKIvHlcYbhB2j8kad5deoHoM9qJn3Kn7E
	hrgAkYoS3Pn
X-Received: by 2002:a05:6102:66cb:b0:5db:3c5b:abe7 with SMTP id ada2fe7eead31-5db90577019mr433728137.4.1761734743669;
        Wed, 29 Oct 2025 03:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVt8iQYzU/SmRrxo+cWMPRTylIgThuFXCVvWS3O6j7CcEyxEorxIzby6E/hdIkwnQRzyJ6Gq3Z30LFhvJABU=
X-Received: by 2002:a05:6102:66cb:b0:5db:3c5b:abe7 with SMTP id
 ada2fe7eead31-5db90577019mr433723137.4.1761734743376; Wed, 29 Oct 2025
 03:45:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Oct 2025 03:45:41 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Oct 2025 03:45:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251029094429.553842-1-jiangfeng@kylinos.cn>
References: <20251029094429.553842-1-jiangfeng@kylinos.cn>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 29 Oct 2025 03:45:41 -0700
X-Gm-Features: AWmQ_blVMwdcu26nurRyUZs5wcTHqNKLb4D73h1KM2q_eXnA-ueZisVJmUt935s
Message-ID: <CAJM55Z9SMwV0Lrf2i-D+1fe4L+v1M6aC1hrQoOWi6Rc1PA-XTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Build loader.bin exclusively for Canaan K210
To: Feng Jiang <jiangfeng@kylinos.cn>, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	masahiroy@kernel.org, nicolas.schier@linux.dev, palmer@dabbelt.com, 
	pjw@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Feng Jiang (2025-10-29 10:44:28)
> According to the explanation in commit ef10bdf9c3e6 ("riscv:
> Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210"),
> loader.bin is a special feature of the Canaan K210 and
> is not applicable to other SoCs.
>
> Fixes: e79dfcbfb902 ("riscv: make image compression configurable")
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Sounds reasonable to me.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

