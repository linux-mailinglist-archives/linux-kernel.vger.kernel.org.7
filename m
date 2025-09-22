Return-Path: <linux-kernel+bounces-826474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDAAB8E9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA45D17B17E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1133997;
	Mon, 22 Sep 2025 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sex1tRY4"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616D1BC2A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758500750; cv=none; b=ArO2tyQs6CzneS3B19bv9ksVLV3NQYWUsUi0OOMmIC3A+u6R8a09NPkr+zNnXnxzlZRdRieHde4gz54dUl1ZclEoGgQQKV6rPRRjVIj8aiYZPDvQ6D3L+BnBO1sRne4Xcw2amxGpMIt8N6fCT7fvgopiI/SrMAdDQTGaxzQeJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758500750; c=relaxed/simple;
	bh=ZYxkvytXWzIneq3yvORv4oZVMuSuCQF+rZ03OyIv+xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnIX5LWwQX3yt5OjYkj7AEr0k8wOoE1717A6I+BKfrxaGF3PaEHgUX2y5r5gm9bfYQ2nSvDVdSqHx8q7pJcy7kSDRAVrpwKwnGlU18HE9IJqucV4DNYQs2WaeB2+lNOuEkwA76UQCVuHZnYji4UalZ0jKED8+Y4mYbxwe9jIoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sex1tRY4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04770a25f2so628286166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758500747; x=1759105547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqow7NfKYjPX1vfqX6Q3EwqJhfVfsFixre7RiEXeVic=;
        b=Sex1tRY4smHZjwxR9y/gvzrQRCmWL2Wpx8XLjPy6G7vxxZVb9nJ2TJGuk94Rm0L5bX
         XHSQnft4THbXJSqg7cLjzuv1zAKjKdhvT6dCdHQWm7kr00JjDmQ52RkXFMXmP5fXdgdg
         f3/B7sdKpvJ09fR7gcfavrvsCyLyiTIl6jrgu5heWK1mwBjhJPOR8TuI9YiAEPQAIQJi
         qG8UkZeVOvVZ3he9RK/KZhwWhxc7INCnIPiEoV7u/LcYTPNXF27XC6T9brP5HjchDQ+j
         KpJ0neABxVhrhNQhq933ihNSBbxa6r82Rdt0zldOHKxlFswBQirmqmlzoJeocoXLt+no
         kSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758500747; x=1759105547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqow7NfKYjPX1vfqX6Q3EwqJhfVfsFixre7RiEXeVic=;
        b=a/c7bmpU23Te5MVghutwUu3hC10BydEVjyBL4lkGdhlpJdqsV1mNCi8MxuFKwtfooA
         1jdPRjlRL+K1Szq2ykPTYS0EvIQoiGsP6HiIL9MJTVp+ubWE/W8f7Zw2i2xgyCh1DTsV
         in1S6lS5YHQqlV5uIlvD9WVW8K5JIhOoyopVsqHujjcCFY7xuvi5LSWQ3ntDiVtadhfO
         +UDS41tKKAtN+YRh7UIlGoK3+aILHoUC9YzvQPlQpFOXevb1o7pOdxr62Fm8MS6tZcUx
         LktMlWI5VJYlknBXvsNlkmn8ji79J6UQspVGGuTKgD6m+4wGNnasoGpUp+tdg9lPkpC/
         ZC5A==
X-Forwarded-Encrypted: i=1; AJvYcCWiO3HevLhYOUJxZ0wEZ9h/pXe0C+vw3wpf8GVwaeTXJeHGqv4luLfnwPU36X75yUVxdO/UrAExgT82FOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYl79uDS8+ge4ZGZI7S3wZWWqNJAO0S0/gXvbOhARklLtpH55
	20dGhANE1CHryq/T4CJnAJmVTke6hsB5/U9xRvuv2kyJRBzFG2Rvgmb6
X-Gm-Gg: ASbGncsC+6cpV/P/BDsPvPcCQcGIXc7Kzn96HKeP0AJfMsK0V2EDsdi+lxNGfYQZ8G5
	O5JEHigrUty7x0DPV4D0uaR2Y58aWZEl7Y3yfkzKUWfv5UWkXlc+07n4ILZS0xiMHJL5FHzFQKu
	36Z39M5hp45c0E5xU/Zihxuc7KxYKdl/Tkki0MLfZlG1tpx/PR2X+44KsUYxvF9wBsEYXd7kfC7
	aPv7oi4ZxGCbV4UJAfg1vgScAYUc/6EbF8uk+YZ/ev3JsyYbsOuw/hqYU6s60Ru+yfZPqSFovaK
	TUwj4cCsRtMTZjRODXjPEEIlEr/ALlmoIjsTQqniDxdUhOVBe8oYiBiUgyiu6Fzszw//nWiIZ7g
	pnuY0te2I3yudRNkWHgo=
X-Google-Smtp-Source: AGHT+IHsbRcdXtV5go1CgGoP+4ok3H92iE4YLKzIeNlhHJMbPBRzYcrLPwri6hTQjbCbj0oX1PYScQ==
X-Received: by 2002:a17:907:3fa0:b0:b0e:a66f:478e with SMTP id a640c23a62f3a-b24ed97c8fbmr1084255566b.14.1758500746934;
        Sun, 21 Sep 2025 17:25:46 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b297f3f426csm374532266b.7.2025.09.21.17.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 17:25:46 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Date: Mon, 22 Sep 2025 03:25:29 +0300
Message-ID: <20250922002529.95574-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> With the notable caveat that in this example, mount(2) will clear all other filesystem parameters (such as MS_NOSUID or MS_NOEXEC); fsconfig(2) will only modify the ro parameter.

MS_NOSUID and MS_NOEXEC are not filesystem parameters. They can be set per-mount, but not
per-filesystem. Here is list of all filesystem-agnostic per-superblock parameters:

https://elixir.bootlin.com/linux/v6.17-rc6/source/fs/namespace.c#L4103

Note that these SB_* constants are equal to corresponding MS_* constants.

As you can see, there is no NOSUID and NOEXEC in that list.

Also, SB_NOSUID does exist:
https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/fs.h#L1240
.

So, it seems that "NOSUID superblock" does exist as a concept. But, thanks to
code in path_mount (provided above) user cannot (in filesystem-agnostic way)
make given superblock NOSUID.

So, from user point of view, NOSUID and NOEXEC are not filesystem parameters.

If you need some example of filesystem parameter, I suggest MS_SYNCHRONOUS,
I used it here:
https://lore.kernel.org/all/198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com/

-- 
Askar Safin

