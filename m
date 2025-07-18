Return-Path: <linux-kernel+bounces-736201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E85B09A03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84BC4A832B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545E1C5D4B;
	Fri, 18 Jul 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei9zX+H0"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37CA923
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807551; cv=none; b=LPVyF4t7G+CDENDW6rvDz9wkWTFCDH16rom7G5BqHvC31vbU/IMNtTmJ0b3M/cH5SJ1s4bh6FAOUhAoLGgtrZoDnoEXuP8euftKken06f0w4eYD1Xgg2J+oolgWEc7x+KrG9OnZwZT2Cyz2zuHRC/+fXbATX8w2yuLw5cspOd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807551; c=relaxed/simple;
	bh=vjjF7HZgZmTzE5QaUT0K8dC1GXXNAEcvJ0+57MBGKsw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dggg3J7oizd1GB4lxR2BwkUSTbgia7/0WsxD92koPfclZyQr7CotKko2qXJJeXLZ9U7lgta9gpm3VThhsyDIyGrOT7mWY3Xuec9tSxQ9ghZWAU036z3DbIzaBWIw/uM2cHjdegwFRjWAYfPPcHqeIFD9+pGKP2CquQj+dP4Mr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei9zX+H0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8d70c65abcso1074874276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752807549; x=1753412349; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4QEueiv/uKqTFrnIsLY/SjTQWW9tYevlmkSRo2zTLo=;
        b=Ei9zX+H0B48fbDE5MTh+rrZcGq+qgw1zrG7W+emOr8HK2AqHTuvVGQr/YdUSY9lq4C
         /V31ZkX+v4aitmwjae9oP+8s35p+pTg3RWi66pZwnJuQdMNxMzSf66ElBvtjwYO63dGz
         0TyYiptd2z5L2HAbuXM4FreVctZdAiy9sz3AQzV7l+hDwZA2qohq/IysulhgBhWItQwU
         XhIgcIYW2rzZmmh9jUBKQ6PqtQpAAUmeYRzuX2fipfPT446eeuPL7e1votOfECd1nNDR
         4o79EXKNKwW82PQttQuRI2W1YE30ZSHwrnD4QX638G9uqByVnwndB+9++xNbKDbEqCum
         kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807549; x=1753412349;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4QEueiv/uKqTFrnIsLY/SjTQWW9tYevlmkSRo2zTLo=;
        b=ISWGASHCOeBSVrbilArRq5Ejnq8mctEYGJcvzZhilhQNjNAiuN8/kJl3GpduF+Be81
         KhdHLokRmqMefTCNcr1HCofWcU9zt3VCMVkEeZ/SucOTiiN6qC23lQCvIoD+K/myxDsO
         C5OnNT6tTtbxdo+lNv1ZmH3IsusF3DuNxrqbqyiRdNydOlTkFrqJtJ/u95yXRnxi0LgP
         8omQO/PxRisQhyKRVcOAoEjBqhdLj+Le690czP1KgpTlXWVhUunhWMFzFn32NAI9RrEe
         3y4z9hDWavhK1D1C0lJBZuZV4awFiqU43eCsYkEmv09YY/FwOTrY/FGm4o9RDKL0Fc4v
         jyRg==
X-Gm-Message-State: AOJu0YxoJHy1m4w4DKD6JxNZLR3h+12i1QfnjeOLCmu1nYn/z/Any1Ht
	msk/jU+mym/0Aovv9w0RcD114EBcPpU6A+LuHRj6sProHQE3EesmKtivlABxreGcgJKYO2jIAej
	O2kUpOrCH7pCJg0KpSIHRrz5aCMRrsXbxwn2He3g=
X-Gm-Gg: ASbGnctj7mjQF2+ssbbe1IOM5ZRYhkAhxnRK5eK5c6QHzX62HTNkezUV158S0CkFmKA
	fVcrmZqeLu3zoAhZZLI4KK9VNGk+qkj8F8Iztep+Ed4kaO7pLo8Bq2f0TUudCGm+H3q5JGkCCv0
	i6C0JV2nnJ3M9uHk41P1cB2h9+U1o7xnyac20W6vVWFDzt66tFKxueoi3DGHS+0ThZrBZRsPKzY
	fduemff
X-Google-Smtp-Source: AGHT+IFQJ6o5fIZXX+jpOeO4DzV0fmixu5GMuZZmECyrKxj3+KDfzWJ2aE+h5Or9aUiKDCnUOk+Ltya92aTnBpVmW00=
X-Received: by 2002:a05:690c:6302:b0:70d:ed5d:b4da with SMTP id
 00721157ae682-71834f36332mr138334597b3.8.1752807548227; Thu, 17 Jul 2025
 19:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aaron Gray <aaronngray.lists@gmail.com>
Date: Fri, 18 Jul 2025 03:58:51 +0100
X-Gm-Features: Ac12FXz4FzD8whub4E7UDxXojkh0Iuxe-H1Cs1s44oC98K1mQ4tfau7ZjoRGWtM
Message-ID: <CANkmNDf1FkXbPP=btJyU8p_Znwmn+sBRDL6fzJ323bu7iEOFbg@mail.gmail.com>
Subject: [6.12.32|rockchip64|rk3588] Display failure issue
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am using a rk3588 based device.

I have four kernels, two older ones the display works 6.12.17, and
6.12.22, but on 6.12.32, and 6.12.39 the display fails to work.

-- 
Aaron Gray - https://bsky.app/profile/aaronngray.bsky.social |
@AaronNGray@fosstodon.org | @AaronNGray@Twitter.com

Meta-Mathematician, Independent Open Source Software Engineer,
Computer Language Researcher and Designer, Type Theorist, Computer
Scientist, Environmentalist and Climate Science Researcher and
Disseminator.

