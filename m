Return-Path: <linux-kernel+bounces-891005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E53C41905
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8104274F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F73370E0;
	Fri,  7 Nov 2025 20:13:47 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D47337B9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546427; cv=none; b=pVYdT0DBRM6trp5DsO8SPWhgc1AAAMXZ7ZLnHZc168qQroZtgadz0UttWFEOyUGY55bW6+A4Aruh26oD/mC+GiAmgp2r9TopKxAIOqivtglzREf7miP9iTfpQpMKnPe+TSG+okrJe6EByDE6vqLWbfRm7mMq3ZQksY81gABRn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546427; c=relaxed/simple;
	bh=09eUTTlY2G0jdVjelC0cqh/VHK7FqJOXK65qTcB6Hvc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vGlksm28kOgsGQ5kDlPJKE6E/2ljAXg14JRuNokFBUrmMwVo8SC8ZI45NX6JhAv430e9CttW/iootlLbkIgAcwwK9siu4kwfmgydHe0cG4LpBFn/EQw2FLCajr9/TZmjE0pIiP+0qv3j5oRMpwZgUEsOGMhhUyShNr5liZxF8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-43326c74911so5306145ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546424; x=1763151224;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gS1PgCh01Jm1QkTVUHmieEXJsyrh4GhNpZPiTdUvss=;
        b=Ti16J0gajf3rtpv+iptiADSJC70E6cChnrmIJ/Q8S1EdhosyL8A0kdflMv9ypr+UAU
         UflSOzbiIOfQoQkB7RUTI31ODa5CnAt5pNqhQ0pepadFvjjAihDvqfPFDNd1iGXalpUb
         9x5r0KcxX/66hsp2vFAk75UO7zN6oINy12hOlgaEr1IH64fADmqqv2tMh62T5EyDYvqv
         2BarL9ltTX0nrFSUE4VKHCVvJtjTJq5gP+gkmPRMauuDFqTyb7MQjWil2vaWNQtbANAC
         NypPOerBaC9hnuIiywYOj+rd+OjCYhyJgEhHT0zhx7E7+YZ0JMOpp8RDdcKfdhO24dzH
         lPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwx/Pp4fsqBMhQyJBf25/U02+wZRht04XPH2nbdtaybcUlEaYD4gowN/vZvf6THcrmpXTZxpdz8fPn74g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLhOfq94uCuU5B9XFnbHX9vVU+b4BSJJBBS/hl1zGBsphCdAr
	l9Ey8xDhJrRqa4BAV6jBZAiZyVBpjaXexC3s3/Y9hH8sO3mXO0BzBfcfjpFERG+Ptnv5ZkR4TPH
	8xutzcExk3qWFLBHVvllOjFmbOKF4rrzlpL0PGB1ZhOP9dKB6wyDMvK1/
X-Gm-Gg: ASbGncstmeAg5tjHL/r/NqwD844PyguIey0hFIb4vl6Axz6mrrOjBl0fSwIQuHXQ/ls
	TozlmVRuS6JStGoBQaS5495NYbdvuseI6jlelK2D5v9gZg+aNBrZgoo74ZIkg0eWdOwLCR4xBK3
	09hkBn01WnlANo3oYMFfKIP2CZzDarSp129t6pd+JSV2fLolv72XYHfVcGgWqyctp6DhIvmhf8E
	Hih3xzVmqBZVswb7o3FYqXnajj3+Bw6JYrtVXKKJm43/DPjlK4MgJzVmAtZDfs=
X-Google-Smtp-Source: AGHT+IHAK/qPwgSmSCJLGfBjqQM2vcUyaaK0ElRhJneu5Nk0cEvEXK8xDHWJ+dBfVz1IUtf47kFhuUgyIobaaTUvn30=
X-Received: by 2002:a05:6e02:3710:b0:433:27b5:1faa with SMTP id
 e9e14a558f8ab-43367dca877mr12429685ab.1.1762546421338; Fri, 07 Nov 2025
 12:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Fri, 7 Nov 2025 13:13:30 -0700
X-Gm-Features: AWmQ_bnxn5ZTxbSrTPWI-CI3rLMS0B7sroSBMNjVbv-EBLTdopH_YiIu0paJ5Co
Message-ID: <CAFxkdArGv91enmUpsuuARGLGZXNJjGZE3Cjsk3NfZS5nCRsgYA@mail.gmail.com>
Subject: Build failure with rust 1.91 and CONFIG_EXTENDED_MODVERSIONS
To: rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

It seems that building withe CONFIG_EXTENDED_MODVERSIONS  and rust
1.91 gets us to the following error:

error: gendwarfksyms: process_module: dwarf_get_units failed: no
debugging information?
make[2]: *** [rust/Makefile:552: rust/bindings.o] Error 1
make[2]: *** Deleting file 'rust/bindings.o'

Turning off CONFIG_EXTENDED_MODVERSIONS gives us a successful build, even with:
CONFIG_BASIC_MODVERSIONS=y
# CONFIG_EXTENDED_MODVERSIONS is not set
CONFIG_MODVERSIONS=y

Justin

