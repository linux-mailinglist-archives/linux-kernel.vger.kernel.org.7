Return-Path: <linux-kernel+bounces-766153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B993B242EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65891B63135
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F12E36EB;
	Wed, 13 Aug 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0wD0hsjb"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4822DE709
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070830; cv=none; b=syZE9jPr+tRnBXBb2I8jdyPv6IY5pJS3Hiu+zkT06lV3hpFvln1zO8cyz5n6SrbD1l7Jl0b9YfmZibJgIGI6l6eg334L7X7fSI92P/LsEQONGqxYK2ZOWg1f01ymLXlj1qPGIAtfCsHosV62L3vI4ZB7pzBxKtAZ4Oz/ZmXc7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070830; c=relaxed/simple;
	bh=sCnEx5761AElVItBdhLveYN321t9Jlst6UmQyhNbyvc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tC8PfIMMJgkNeYAB3JLTX/Xz1+s/cBhJ9Dvt/DLEXj/vwavyjGGz8fXaz9K8CnXj+jiLNhLwlDxJTe2C0iOGnp9kyD+LaN6gKYdfBJ0pqolJCIBKv3UktR8zxnpbgvZYKeryxasUDxII2JIdqzvtUD8eEf6RUbz2FAPyWRA4FX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0wD0hsjb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b44fdfe7b8dso2492852a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070828; x=1755675628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp49dS5+lV1sQl/6tgxifknga+Oygf66Wdoq0OTUz/4=;
        b=0wD0hsjbLX3FwrhHoVmDdJBvz3z+5X9oJ5Hq3mlNuej/lFpHuguyCjcXuB0x2QE4hi
         MowJF4JfhRBPv4S96W7fCpvK1ccTgajpjK/miSRS1JuiMN7BAwSYFsxEx8h2+5vPy4xw
         o1Yq1N7ddATblwxzW6o5N/DnCwJZ+5vD3lqjQ7TwcjEUleLlbxyN6dM8AfNjrfHRnOgt
         KoYEq0pfSQJhQPZX154j+5qqvafSlUzkuXKbRcsJtgXXAVv8KPTG8Wf1RzcWeZ96voY7
         Tdy8Okvq2aNkK8LIbrmjLqZrmmeOt1E4rJD2PHeImdWrb8RRL/ALXXbWFu1Z28ZLVN+K
         CjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070828; x=1755675628;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp49dS5+lV1sQl/6tgxifknga+Oygf66Wdoq0OTUz/4=;
        b=SUOEqjmsHFDEsZy8VSSqzJN9wYK+InSd8NgZOoGhF3nINxb0oyXOt7iBU8+BXGjfQ+
         F6FPBe+wNVoWnaatV1QV3YWFtDUfqMaG81khp/DnVTzKlvtGFRvh6abJmTq2coZyGB5Q
         Aqchh8+hOadVXGdvmdn+zW4X/ND8YreqjJZDIwWm+9kilZHhbk0aSSlHm55uGBbYnY1T
         1eEnwQyBB117M2erhgg0C4erGMQDj3ergYIVEqVXttFn3tzOqvWPEHSBMRgsgF5PTA4P
         JJdqfnBEPdvDRlyLDdvnLh6Uag9iitDmhy8KMlchaH5W5dJTjWXOhZpuG395IXhLxFDc
         +M8g==
X-Forwarded-Encrypted: i=1; AJvYcCW7uPi5imeCmy3tNAMPh4Lkg3BjeiFsHsKYT/e+kDUPql8AzXbX5HEDmA7uVvLtqeeOwA8VrN8VxLt1+Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrZje4w4qm27VhOYLoRcvcwyFhmW7b4McuowQ3qUVFw7KcS1y
	Wqi0A5SDA7556lx4WYraKuf9np4uXRjSmcVFYaPhdg9p1yoBoPy35Gcwt3nkpD3TnsDnslTSbg=
	=
X-Google-Smtp-Source: AGHT+IHL3hixZQwLVi27pXeiL4huS+wC9o2l4Q6jqQo5VnnAnaUPedzTkKL+Ezbxk46oWK0muukHVbbV
X-Received: from plhu3.prod.google.com ([2002:a17:903:1243:b0:234:bca4:b7b3])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0b:b0:240:640a:c57b
 with SMTP id d9443c01a7336-2430d1f7829mr33241755ad.37.1755070827983; Wed, 13
 Aug 2025 00:40:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 00:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250813073955.1775315-1-maze@google.com>
Subject: [PATCH bpf-next] bpf: hashtab - allow BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH
 with NULL keys/values.
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values =3D=3D NULL
seems like a nice way to simply quickly clear a map.

BPF_MAP_LOOKUP keys/values =3D=3D NULL might be useful if we just want
the values/keys and don't want to bother copying the keys/values...

BPF_MAP_LOOKUP keys & values =3D=3D NULL might be useful to count
the number of populated entries.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5001131598e5..8fbdd000d9e0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *ma=
p,
=20
 	rcu_read_unlock();
 	bpf_enable_instrumentation();
-	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
+	if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size, keys,
 	    key_size * bucket_cnt) ||
-	    copy_to_user(uvalues + total * value_size, values,
+	    uvalues && copy_to_user(uvalues + total * value_size, values,
 	    value_size * bucket_cnt))) {
 		ret =3D -EFAULT;
 		goto after_loop;
--=20
2.51.0.rc1.163.g2494970778-goog


