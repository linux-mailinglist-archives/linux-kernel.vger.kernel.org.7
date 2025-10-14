Return-Path: <linux-kernel+bounces-852862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BEBDA1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E19F3A53D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D93009CB;
	Tue, 14 Oct 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU7eZR7V"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C002FF14D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452856; cv=none; b=YG01nCp0uhg9dP8dvERq3dDDZh97vmGl/gY4dlmcAxmEETl3Zrb57UQQvf9nROhnXnhlAE7juedAhRGtVle5Th3Jt2qZBA/R0Wl4OBvBUaGkuUbzK94aUxkdmGC7L0h7jcbSNLPTbx/ftQR78hvYG/3iMJ4lJVUNMN4NOjIftVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452856; c=relaxed/simple;
	bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhkgJ5EJHq+/9SdNQKDGw7WmKbNeP+nyWHDkqLofvZX8V0A50oU7sv/kgStBAtC5fFf7Yq/ff8PxERMnQnzqlnUsp1tdRRTIgh7DKD907al9bjs0s0iMIcjY+Bazbf0Zb8hxYYlEpXo2PoUtAdLiWUw8JZPLgceT/OjqcWElEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU7eZR7V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so735185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760452854; x=1761057654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
        b=qU7eZR7VWY9qR/+uMfAVJYTItPxnppqItwoUpkzZDiaJ+0GBRMbgx8bheFrXaxUQka
         W582Xfwdp8pZnLF3mNWNWq/iupd4SH+SsZeQzuhGKeKxC91qeJSbNDpOKdmwluv1iut1
         7Oqjdlcfs1WcaBEZ2yC+laDCKH4/GtcWjJiqKIWyIWe/VdIojn4JhH03xtslVqeu+SHj
         Buy+w4HjDukQivw0tLGtKFnUC4huvXtpBSGDnXx6YYQoZnFgrveYpTz154uNNuIM7MM6
         7oIX5QFEbI9NM4M6dBw0OxYyjqx19O4ggf3s0wad8FLfxUlDaQq4TkQwO3U1PTrrfRqQ
         Xj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452854; x=1761057654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
        b=aaK5IBYP+Xj9QOGgF8oug1L/ZAvAZamqP8TefrOJ8xEm+aYudxx+bIBDpPcyLLvXQP
         ITlmfzf+l4CUZqIKLH03OQcH/CvEIVqbgAMPvq1lcCdnSlHqww1cD/7TCEQWyZuSUA9Q
         xjnVDSjAWu1y+gqmvg+++7atibtVtdb1HYSS9lDzUeWhS8+JcOqkpVnov8frrH8LkeOM
         NdRhgHqxbX1Henoyffb3t0JWydrRQqVVwJ2/kR+MeXhdP16y2pTGa8uo5aFZ1iVQkk8y
         dkKcZQHienjuaaY5GPaQAUgplLrIZVW2Aap76g4iwtWZKPi3kuxNP9wosA9P80Vy1TIH
         Orfw==
X-Forwarded-Encrypted: i=1; AJvYcCX1h9Lv23sitVl/EF3vQN1uIxXu8oB5g7cKIS/zEc1fJAB3WY/56qN0pp/NCmFoT3hS7Tm6OhGEeY0qhDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHegzp95mIR8apvhxtb8EQR7AP4v9tgiEnlrPWHS2Zys5dcS7
	xY/MfTo07qKAg9ck27a2c+vHG/4WKhdwkQ1VTIbUbmnX8n4ZwSVPuvGxT2d96HlUREhokYvWqzZ
	rfP0Hn8+ZE/gpva9Mgz588sX67mvsiPLaPRcUe3HjJA+zGQ6siGxlZEKyqWw=
X-Gm-Gg: ASbGncvgHQcDmUtKWPII/r5WGixSxrOF5sEBXWZqWyk5OSTKJ0vgPWVX+a4QQVpSBQw
	AL+9gIYxCBDdEbp2q4F9LRlciUpRgTLlluiJ4L4HafIdO4o8jO7Iw2J2jC6zblfAgTEC2vYjx95
	dl4A3AYWRTjoaHtPtxTKL3nY/BnJF2iGtv0Nz/wPD9wVnTpol09Jt+KhmNjuZln7bOBMZ0bKsjb
	j5vyc24VjvpaSLEXygEMhwkovGxwULxC8cYLfQW9N8uDAKMa4Co0XIFS/CfpUWTQUpcsBkHmg==
X-Google-Smtp-Source: AGHT+IEEg+Qlx1F8v6GOZqbMCmMpwPTSQkRn7icyC0J4Ul7WK+r/sh3gEihm7+CRTLWikmx7RGdEXelYtrNLtfx9tP8=
X-Received: by 2002:a17:902:ceca:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-29027600f6cmr35086445ad.3.1760452853859; Tue, 14 Oct 2025
 07:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com>
In-Reply-To: <20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 14 Oct 2025 16:40:41 +0200
X-Gm-Features: AS18NWDK3JVbrYrBllRzjfsjRSq9Nkan3UUoQRMetB4LzmgAZBq5PRB_jdQIyt0
Message-ID: <CA+i-1C1dU8gP=phC1UD=sc62Gy=ODUN3oAeUUKRnLJgMFW-OKQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/run_kselftest.sh: exit with error if tests fail
To: Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 16:35, Brendan Jackman <jackmanb@google.com> wrote:
> +kselftest_failures_file=$(mktemp --tmpdir kselftest-failures-XXXXXX)

Argh this is still wrong, I forgot about Thomas' other comment from
[0]. I am just gonna send an immediate v3, please ignore this v2.

[0] https://lore.kernel.org/all/20251010082310-b25e69f3-4568-4886-a0c9-3bd611bce073@linutronix.de/

