Return-Path: <linux-kernel+bounces-850233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8018BD24F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBC524EDA09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3532FDC38;
	Mon, 13 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzOoAAlv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B892FBDE2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348025; cv=none; b=Qus6ypiu6ahaBEmidJtwOGPPCXTkKcRZi82b1+90KhGfiGwehCLSCGXcEZBNIBoip6il8K7SfGzpY0BecN7amNetnRi/m1rxr5BvxYJFmwuKNTFUq3YZRcTihcNyazSpgP9XtcWjWp8992lhlpRrAPbb7FN7EddH03kfKeui9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348025; c=relaxed/simple;
	bh=1+iLS6b/35Hb2nRBPY+kv26gXXxahMwbMhi2uq4fynU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RX5xconnSjs5ftnh02Dw/iVc2cVmFyDWHdZhCXc6MqS4vKBfrCjNcKIxPadZt0KZYnWYCE+tD74Wod9UYdNWwqSvL+lsJhS8+ULzcJCMZoguKz3VdUs3ps1PVU2PTaeFVFzThzmohLvWCp8kDUnM52Zv5zysXzUPcyhnFheM858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzOoAAlv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789fb76b466so3538924b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760348023; x=1760952823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKlhmybHatxRpg5IBkl5HmNvsZrEn5pX6moYVoKC+FI=;
        b=PzOoAAlvO5RpxJViASg6TrWk5TXJbCICAQvpL6ZHAW4D6FWQH+T0uuTJWeJe4eFezs
         ESN7wO75EJVPzkbtpZnxLFZ56Bk9u09+mjOpXf91HmXmJnQYAHH1etyz7BRhiO8NBZS0
         jC2FKH5zFp+8bRcOcz0MKcPQywmoepao1WCZLkjS/YqhEQSqAU0HdtcJXlO6PvOF4gmD
         p5Wr7WwcZ7m6ysNgFaEYYlnD4ztU455kJWxdx3mD6Hpvq3qb8BOJorn2mDxTUmDKhGzr
         hXTQ6PKZrDn2ILwn/6w94UHTRd4V1r479v9fEbFpwhlcn5rdhY9ro3dl1jLBK3QiSKCH
         VpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348023; x=1760952823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKlhmybHatxRpg5IBkl5HmNvsZrEn5pX6moYVoKC+FI=;
        b=ZGEPn1T0Vgk0eQQR41sUUUAiEtlZ0g2J5+Z+98CgU8+5tTRHqSfCnxjW5ikEVB5DjP
         fERpxGgVNwE2egmqnhSJYDw66QcfQaFCkwW+9Wi2KNnOtd73TvqG4nEt9YSN9QYZ/waq
         q+PWw5SHqH3s1Z75dyZy36INRsJUoRLkkKR2BczeSm99L5hM91nbyJXbQKQfek9ReYPh
         QxPfWrxbVW9UiGnNF6ZgtrH3GFSKvFWnQHU/JKCeCIsAxHLKi81IhQjHudITjPFIFw4D
         y7QTGTBHtkywUYMqElsEsdqUV2ZLJk29duUWmUZ9ak4BaWsTMaw+h4rQrMV6uXEgqb6S
         vWpA==
X-Forwarded-Encrypted: i=1; AJvYcCVWRJZlyyzM3lOozGOHczE7jzL+sbRX/8+ZIsV04YB8KLElDMFa1UUb3lMFMmZdBeb5sF3sTUPaS9YT33Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRbszNkFnuH4REN80Pux181GgIBYlkVV3DVoPKFR2jB4/8KIo
	bAs5cfD8YZBeUSD+lfldvdXOk78iCy9NTQ05O498biZUornGmx9sDzFhJBUsG+mXx1A=
X-Gm-Gg: ASbGncu/nM1unaKiZWKQs/wYeETU2dMsiXlpywsxZF7VRSSRt10s/aeTCknlx7x8ybA
	RCmUS63cYYEKPPIkF7bQvBDaUxw/eQrQ3goP93Mg4kPb6p26ztn4GOfs+N4xSX0rLCYjApXVVFt
	xTbw+zH2kh03c3btcS+GahCjGx90DnLwko00lzToWt19iBvrOsyOy1BgyPnsQyLBf10QA7+BF3l
	oz4OAib5WjIjV8Zm0JMN8sqaI5RhGJ6rYHnuteubSZa2qx0A9pF9Ajvnh5Vdw2shacvxCSWGDLN
	6GmgKU/kcJVkSGte/y2JZ3o/kerMy1NONEiAN7i7RK2lCevPmhBEsGQTHgBv+E+rUxJ6czQVZBk
	duDccH0T339JjYYcFMcWKR4oUXq/Xqvg8EF4/eKoqFoGwAPbc7ifR5rUnu4a3zvYBsQRQZrwush
	LE8s4IDTayrqjBm+c25HzmBg==
X-Google-Smtp-Source: AGHT+IEW3HkbeSrrSoLDwpd5ubdGIbiRspp08NgqYs5rFKr4nONDZ+iJCdPKEl7AfbxqHcH/3OzBiA==
X-Received: by 2002:a05:6a00:194d:b0:78a:f45f:8740 with SMTP id d2e1a72fcca58-79387630b96mr24925771b3a.19.1760348023324;
        Mon, 13 Oct 2025 02:33:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:abb9:ca1f:244b:3697])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b63a03dsm10905642b3a.19.2025.10.13.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:33:42 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling huge_pmd_unshare()
Date: Mon, 13 Oct 2025 15:03:36 +0530
Message-ID: <20251013093337.4432-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

That makes a lot of sense - moving the assertions after the early return 
checks is cleaner since the locks are only needed when actual unsharing 
work happens.

Should I send a v5 with your suggested change?

Thanks,
Deepanshu

