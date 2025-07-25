Return-Path: <linux-kernel+bounces-745378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F8B11919
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8467DAA22A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A8C2BD584;
	Fri, 25 Jul 2025 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="a/x1jTyK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E35291C0F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428236; cv=none; b=VCZVG0r//reo/+MToSrVHFSm1hGy/gizkV9+FpNLghPQz4X9ghlmpSz491q7bh3JJv5+f+2jWMpzV9MVN+jXpyRPENz9AhWPIuLLtUc8rXzTiw4vi+VmrWU8r6Nr3Heolikj8u2tVIhEOffxHjDc/dvhQwpoKb4plkqnLqrhKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428236; c=relaxed/simple;
	bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRRpW/+qnOd84z2wbFHlucEAYmcq5IdrpzqZ6kWXrkKPeY6H+oqVO6o7XjYR+rFgtkfGx+mW24Ku4giPIy0+HWQnumNyxOnv4vChXB7jdQjNkUVRtsRW+ND5fmlS16wnrcRMJs0GyR7kQWlo032ZHdLtqkFdd9ZlHZcmHhx34i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=a/x1jTyK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1343650a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1753428234; x=1754033034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
        b=a/x1jTyK/qKTitJcYkrWORBcR3ydBBIuk9npKyqEcV5Q77voed4cQrGDmFUUd64rri
         ctl4IW2caIijwYFYGZ+xFmh+YRvgfeLZJcvZrjQJZL32T7BWnnAWR1WLdGR1ZDu1Y4E/
         G22cXQ1uOhPmtthWU6gwLURcNj7/YD7l8y6BkKrhnfhxM/SmmEYN2+dSFNm5KGhxGKE2
         HATzntig1ZX2JQidJZTcUovNAZid26Z9EkuEB4kQ21ZIOlPyMRgk6nJI8aahQI+YUGRM
         H1eBhEuVpJKM4jESk/hbUxON1Nr6Y/BvdTGI5nGmieMPIBZhYa7MuCYKlqzZQESddYv4
         cgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753428234; x=1754033034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
        b=dOQX77IiQF/tv+bWIbR6fLKTNgHqxKWEzEpPdftqRoCgf3yykmKigQ0KVXyiK7/Nnu
         Mpl5pJefzarq7CjnkM2OM4TqnKTfAhaqKk2SW7fam9t8c6XpVBCY/gHdYHBNxg1SWvNe
         M0h0aj11YWnU3ID//UlGJPyBgfF4DoTQvYIkU7T+5e/vkmjhFNeFGLoSfKXwwvOdf4b4
         cZfQqvl18zmFcwkA1J3VQWXV4o1in98yz+n+RoylW3jFnUIw4T+WqbJFTuGpHsog7Xji
         fXxSlzXvasMepmsnfkdtp9LqawWy2bWEmTLP2Be91PSt4mpRaPsGdcIpro1sYRcq1k5V
         g4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXHy6JNonmKwE0uBDl/OsjaTovoIiyE+cU/JudggP+zsg0ho4VKsl0zclLppjHI5GLxsd+AQ+FCxmKt2JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJ83H4WSWEbFz3et0r6+K1G8BjRv0rbgMUaJVQ4ixPQnbwCtq
	7n1EOUqWb8nvNM9G76kCOayW+6+Vr3X0vK4nTCX5sLdM8w5jgFD+MC0N8xoqZJgaJuE=
X-Gm-Gg: ASbGnct+Ak9wms0Ga2IdG5U8DZtlMQE7J4g6ugqQ0TmvK8CGkZvS95ewqxN/I7ek+rj
	4HDa+zH+Md/god/DLpRWskHtI0ONzDdkaUchU6z9KegIIz9TtdvTgTqSNut4irGNzUcEnc7gMnB
	g5WKew9bMVXY0RCRAZhofvscSFjZw5tjVrJz5HXtVO/odI/XQ1yGdw00YROmhVMx7Ei8ZXew/te
	7l5p77LVjJN/XwBONkX+Mel5pvJR66O41wQ7rrJUAq2IViM7WmvSxdp81hpr1NHCOszxfvbzE1S
	FhkAOgNwroP1xlPJHVOjWrwGrp2Jc4jQ1g3tUhLQ3l94QDgrpnEbHFTX/8gIbOYeNSl/pKHwNJc
	L91rBbOLunVzAyehvDBVm2C3Ek/Z+pjbx5OAztyo0QkFC
X-Google-Smtp-Source: AGHT+IG78dnuQvUMmwTY1TJKn/E7zLAL8E9WAkLrjUIa7PmZipcS23LId/93uoJ0ZMRld5KUadbohw==
X-Received: by 2002:a17:90b:35cb:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-31e77a3266dmr1491815a91.33.1753428233845;
        Fri, 25 Jul 2025 00:23:53 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:fd43:1ae:25a:bcd3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e62246f8bsm2119998a91.1.2025.07.25.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:23:53 -0700 (PDT)
From: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
To: rafael@kernel.org
Cc: 409411716@gms.tku.edu.tw,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PM: Use nearest power-manageable ancestor
Date: Fri, 25 Jul 2025 15:23:50 +0800
Message-Id: <20250725072350.43631-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
References: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Is there a specific use case in the field in which this change is needed?
> If there's none, let's not make it.

Thank you for your response.

I am not aware of any specific use case in the field where this change is currently needed.


