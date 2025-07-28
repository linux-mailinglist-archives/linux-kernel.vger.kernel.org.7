Return-Path: <linux-kernel+bounces-747897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E305BB139E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796B13AD3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BF25CC70;
	Mon, 28 Jul 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyB+cqAK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017B256C61
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702330; cv=none; b=MO9lowq6o60wQgfADpc6NN+eFxEuI0xYXqlRVoGN2tfkL80E0JpxyfeS9GVe5nDT6/go+1MmsWKzTA0m8OFrNDOogFm0DD9A1RWxXEBDnoU2EtZhffrkpL2lhUeEcQKINr+sHK0J0lnZGE8hQoGz4QatTt8wiwKzIlc69rVjeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702330; c=relaxed/simple;
	bh=Duf+dMjw8aY3ItxzBtOHBzFMZW4TAdLWJlJDlsEg2Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6EJN8cLa9qbBSKhadsTML6Ewjlb/UEpBoHWo+gZ5qZU1UJMnlQS34gZbqMKh+wpF7e5OjonUN8y3+jutri9DXpJXKvCFFHF9xbVxUVmqgoHwDo25LAdQ4ryAe/d6CBBmmeRiU1w3Bn4KUzUETRill5xoOkMS94/ooazb6x19n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyB+cqAK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74ce477af25so2780879b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753702329; x=1754307129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duf+dMjw8aY3ItxzBtOHBzFMZW4TAdLWJlJDlsEg2Ko=;
        b=HyB+cqAKvJap3cJTzfb3CWRxgFWpcs6d/YQ9i+fDHDHcoqv/4QNzbYF4A0oz/IHIyv
         NCiHbrjOhFtIv58/lD1fsqMPREOXaiHFLztIYCrTJk+c7H4Ks/Gzak9xaTvv4ZqaOKF6
         26iu6tVbHdwGUED7k/CTm+bzE1mn779I2r/jYatQz8c86yEyNF9mf4a0rOPX2q/spAJd
         EA5iF9NfqxLCkZPT2w9+YstpuQ5GcURvIe5fpkb6FnX5GZ9biSDpsjZjcf7kOxTGdWSM
         EP0jknGFjeH7cPd9rOMjudNPQ56Qq4XQ/rFVQNxrP0eFboxXdHIaxIbn1K3E8PWyQwQX
         F2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753702329; x=1754307129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Duf+dMjw8aY3ItxzBtOHBzFMZW4TAdLWJlJDlsEg2Ko=;
        b=TobRqK+TRDshrta3KVmG4X6y0mxSGFdeuuTe0lx45uj/A09GDDisHITYsnVwEZ+gg4
         O3MNNuZIhzRy6ctxEQTwYh+mRT0ZfJQH+XxQVqaxTRAHuTJyuWK3bXu+RJaP2tzppL/t
         pgkxg0nnJjO0vDUrxYiwpvf8EFJ5vTJrdF5qvxKc3ylNL0cNZdISRPAhV1BG/oaqHksx
         jXSUNrEelSv9p79Gs6NuQFb1jFL2Uz6Qvag6/YaJLgovQu3dyJ3nKs3LZtXcsp/OwPEz
         EHF0lWa3K0DS+odsohBtqzuoPE78Tl/mVs0tUZcAxD2gycMaUyCH2ws76UO0loiWoGle
         Xocg==
X-Gm-Message-State: AOJu0YwY43ibnzC9S3RjjlpanYBSn1swDAO6REVzsNAhNTU3erBseyds
	SWg/J4NqOvuh6Cm6LT2QXONLv1Rme0N/4J55AHjMTOo23r6RdY2DGTpAO03J9fX2
X-Gm-Gg: ASbGncsu20UtltEyZnFW3ei2epQADRRswyKFEHwrOUTxTeS5BZCS3PVcYXIuusDDcsB
	QDOf7NpqN6jpKvozxy1QojPyF351ymgaKmL74IFBTk8kGhGDLfZ62/vdzHaRnRuejbIDBWdnfcf
	qgdPmEbwLmSySobO4jdc/lwYgvZ74h5pm+9lLjdIT+5M0zLQscox/2LKHWMKUEMe+hIl9bjKlGt
	6dFNH9Zf2zEE9Fo8iON4JcThFoYRznw4zzZd6LR9EqcUiiDHdQZKOlZMgOUMa/nuZc2mHJnynw1
	ONKEImh5VFnw+tWhyRNK9u2eAnDrnLgWfCOCgsgmm6pwKPTxaI0SHZxjh2KRP0OEwRGDaOM+067
	bUc/0A7DjfUsWCGmBKWIixKU90Lb9HdgnY5E=
X-Google-Smtp-Source: AGHT+IEU2q/9Vm2MPKh0R+NWR7/L5ly+x92OLQEmvj4MNoEWBBZFpzm9PFjbAPOdywYwWW28t5v23w==
X-Received: by 2002:a05:6a21:6d96:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-23d70190c47mr21828286637.31.1753702328510;
        Mon, 28 Jul 2025 04:32:08 -0700 (PDT)
Received: from imran-device.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640ad06dd4sm5368106b3a.89.2025.07.28.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:32:08 -0700 (PDT)
From: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
To: pkshih@realtek.com,
	kevin_yang@realtek.com,
	rtl8821cerfe2@gmail.com,
	phhuang@realtek.com,
	damon.chen@realtek.com
Cc: linux-kernel@vger.kernel.org,
	Mande Imran Ahmed <immu.ahmed1905@gmail.com>
Subject: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Date: Mon, 28 Jul 2025 17:01:50 +0530
Message-ID: <20250728113150.39494-1-immu.ahmed1905@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f420a63d63334e5b97e7562ce5be0d5d@realtek.com>
References: <f420a63d63334e5b97e7562ce5be0d5d@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The implementation of sysfs_emit() internally uses vscnprintf(buf, PAGE_SIZE, fmt, args), which assumes the buffer size is always PAGE_SIZE. This assumption is valid in sysfs, where the buffer passed to the read function is guaranteed to be PAGE_SIZE.

Using sysfs_emit_at() is a safer alternative when we need to control the offset, but both functions still rely on that fixed buffer size assumption. They are designed specifically for the sysfs environment, where such constraints are well-defined.

sysfs_emit_at() is optimized to work directly with sysfs interface for better performance and can avoid unnecessary overhead related to formatting the output.
With sysfs_emit_at() we can avoid overflow error's by using the fixed size of PAGE_SIZE.

