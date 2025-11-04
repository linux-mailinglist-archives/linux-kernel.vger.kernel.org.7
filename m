Return-Path: <linux-kernel+bounces-884404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D788C301D2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D171899D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A152BCF41;
	Tue,  4 Nov 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL/20NKc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B429B8C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246320; cv=none; b=dlqLUWKnoV28NG4YLIbj/hDs0fMX/rbmrm0KN3bXY/l/4eid7qdrmP9nVKkfMz9YVO64q6JAZyaD0le4ap+tj1QDtQ4eillvCSr1TMrtiDhzwZhZY92sRHBLSp3P7XMH2JIa+eMssYxy4/UfuupnjawWrbU3uPk3mQNzUoH6ejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246320; c=relaxed/simple;
	bh=KXSxoWGzf9FiNThpJFkgtS4aFzPKFrUrk/LtR659nb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZu3cwh125KrfQgVl0pLRBEP5/35Kw9NR/jJp/UR4Lx+pTXtNiXFe4KdisJODOREVvYphT4A+AFHoBwm5lLjPOO7jDsP3mJFpIEt2Df0PmXz7BvCM6Ai8oy+rq+l90rp+HyfwjGDqOLsn6U/5oAiCLaohKsuRacpI/b8RRELuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL/20NKc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so1531457a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246317; x=1762851117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXSxoWGzf9FiNThpJFkgtS4aFzPKFrUrk/LtR659nb0=;
        b=NL/20NKc03oYGU/KMHiQ6UeeDvFCkdkdW1E61Gu8fpGeta0GZGZEf9G7+OjnZ6O1cf
         yHs4adZhmFDNv1CxSL0tgeX0q1J8n0Vaz5j8NKaFbxdLoUCmialp1N9Ar5P1Z0XESplV
         yoxUT+++oRhM31ToqmB34wrHC2iJbv+1FzO5KYrBmbmWfuHyRqdQVv+LLDf8UHOhWasv
         sF12bUWL8KltOeNqOcvKnyAcLk/HIK595o1BYHLPvX7X20srBhHZKa1ew5OwX2pYZPBu
         IxV9/6df0AxF/ho54Ac0Me1kCXjpAC7mjrorqIGHBhmyO0NjozKs9ONTTpz/bkRJLbf/
         L2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246317; x=1762851117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXSxoWGzf9FiNThpJFkgtS4aFzPKFrUrk/LtR659nb0=;
        b=GDEC+fHDUPblE3LGAmBiulvI3R357cvOfzpzl38QCbQFw0ynWM7WR7T0GjL9gk+kMi
         NQOQgp8N8BQWwTLs1xWpQJ1en52SBlI6FIL8CZ8shIC8nHEPAA85qnE3dsmaYPcgof4b
         G3hVToTo+91y3xMf+4giboPI0aj45tVoK7jERACBAtEI9LfA7pKuA1G7s+3P1AVscz0d
         ps5HnZhj4Luj7p7IM+Dx8nyok9MjswjyUXuzkKVDJOIUILd5P3hFmAYRsoVkJwv6K4IJ
         2RTxPfuEilYDmfsUTmV2HiBciUEV/0SidDAFagX5UbkqU0XJMPRHyWj4tK2lv+xQ0bUp
         9k5w==
X-Forwarded-Encrypted: i=1; AJvYcCUQT5M24mAk/QtE/CY6NLFdbgtFWOqo8jpH9SXj1idGeZ8y4/JpiWPel3WBrDFOX3K4ynClDm3vu87eWlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINQ7G0RD5FfYKuk6UP9EyOXZ2Zohee3FPGdI4lsd60MIqqEj1
	p4PK2qjptrDhgIwoXLMA78mjrDX3dO5ayz1k9vr8X7+sCsh7AfhLvWCLhgkl5THL8HXCoq9QAEp
	SJO9WdxIk1sP/paU8aeupXM8LGpL8w0nRGolf
X-Gm-Gg: ASbGncvdlyxgwgPnGuBPQGbzx/8IAbiVI1aX58TSRnksga8xSwASkP+BfWVzgq01qN6
	/xlkI/yu5Eko1tdFdxgxyWcKdrJNO0KCOOsJKn5vFIL0W+96ctViSjTAt97lu3G65zdgwCTj+Lo
	hXuLf5Fnai5V1x+yatyWgbxfzayvUVscPcFcFbmmcIuXC0oWwvhbtUp81Nlc0C0ocmeL9f445k0
	5JveMfk84Vb3cPr/nLhmVUYXyX3cLQVWh8gZWDZALfxgEpmyfO0ZkEyBrOFhA==
X-Google-Smtp-Source: AGHT+IEuqli2bsyC9TZE1Wp+7k+jk5S8Rm/0j0s2XRVfDbAJBgWcOZYiVeocIGE8iJ2maBEZG9erjme0ZgDgEPc0Flg=
X-Received: by 2002:a05:6402:13c2:b0:63c:276b:1504 with SMTP id
 4fb4d7f45d1cf-640770bd004mr13656405a12.19.1762246316995; Tue, 04 Nov 2025
 00:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103213656.25912-1-linmag7@gmail.com> <0ba150517e0fd331f1227e068fd37e6e6ea42228.camel@physik.fu-berlin.de>
 <CA+=Fv5Sdf732mc2c_xGDsJqq2pS-EQU5d0XLBR7v-0GdgFC5EQ@mail.gmail.com> <69590ab694891d84acd2b4a4317c2fa8d1a98344.camel@physik.fu-berlin.de>
In-Reply-To: <69590ab694891d84acd2b4a4317c2fa8d1a98344.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 4 Nov 2025 09:51:42 +0100
X-Gm-Features: AWmQ_blH_3s2dU33LPzAacTZYIaA1MBELBLiqo8cW1mDoEMW-zIKGOiUQdDalQI
Message-ID: <CA+=Fv5QhoHsS2EC_QR-zANZdXTPeQmOLoP1w4LNmgYNqryKb+g@mail.gmail.com>
Subject: Re: [PATCH] Alpha: MAINTAINERS
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> That would be the v2, you already posted the v1 ;-).
>

You're right, it's an occupational hassard to always start the count at zero.

/Magnus

