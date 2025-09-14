Return-Path: <linux-kernel+bounces-815769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE5B56AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB258189B654
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE82277C8D;
	Sun, 14 Sep 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4l61iDq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69451145B27
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873120; cv=none; b=BO707//wLY9o8Ln0C/kp/TRLhKfz4gM0nelgO1FyiBd/TdVo+JwHHrwpAU04XSE4iEnd9J7H7wd2AY2GEVADh6IScg80w9+1ZfohIhdXhovwJ3hQ/GGVAs5oggEc6/jhHYdl92wWbW5D5g0/jXaaWaBN42PZrTG2pibPKpmCang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873120; c=relaxed/simple;
	bh=U/oSZwJ6hXUZO7BXYjUpX9PpBgB1UmE/oYFBn6YfwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYg39+sOPCb56Zsr00edpKkQdubfLSoxBSaSk+UX3iToQl+ihdILctdpKQsRrz4cMcHM+D8g1TRvuVZ/z+10BUgRdfM5oFclZpJEkVxuouDxqS7tqWBzvqHXKGf3SO7Tqt6ywpgkFK1z8gO1JAZ1i8dHBJI7P9kBHg7e9Kte97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4l61iDq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07c2908f3eso372192566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757873117; x=1758477917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KN1lZ+2zq79cOp7ZHM2rwumR146D9sFEX36wlxfX34=;
        b=D4l61iDqujyd+oYaOsEP8qgqe4daQr3cKNlUD4AvDp3nV0lY2M1hs+YDNzjiSh/pKg
         1p2aV2JkQdT/xWs93jXafOSqY9BOOekgvNHRRZk3QgkCRrvby8YFNXEkpKWRUTizW06D
         reIiROITB1OPH5awW/z3j1CxlYvPVkIQH4C61k2EkSvUICrw4eWBGTjzcO0VndrV0CDP
         JE188cAqRL0K2aOpHk0Z3K+nhIT6BZNgjDxlBXPiZGVkimib197Kbs3FUj1WOTLGFwFV
         gT7WXOMbI1oZXrY/t+zVwDya50mPs6Q+3SjLMYxP6uypTDtkYq9iqq4IKEBDARDxuLTu
         r/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873117; x=1758477917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KN1lZ+2zq79cOp7ZHM2rwumR146D9sFEX36wlxfX34=;
        b=FjCzECfnmhTaoJfm6Pan59hFS+h1FznI1uP4dxgkj+BY+nQHil4EBBSQa6j59aqORE
         BVty9TYvUoI1f+0OyXyEcdRP2nQses40bGHH9XGcKctTVDGOadxHn4Au0uSTkF3H7rvX
         DR0keqnvZ9VT7a3Ryg8aGvkOFHhXrygVyTwgSRi1DJzoLpIe7KdySNvKQ65L6XwDMc8P
         B7CMwJSuVVrBjwdEHC+106sfZjrANHsjMiXjnUvnFyWnTbc+HwWAf1A7lIpsJZzfE2OC
         oLK1BX+bWsjGQCc3gO1E0fpLTKz2Q0KuKZ3li46URZNykqxznA5ihH4aY3C7m+FwP6p0
         e8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq82Kd1jzxcM+gPvHKcbJq8kXoPrIAMUn5bwsw2LgBLrYdLF1knnZbmEqAL26giHYUzNej4LOc6MKi77c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWkMMBxoPRwCL5OM0tmlgCe4qLr0jRvqA6hsrsN5fEiPTTYSu
	cHevuHtT2edGZHP3h0qbPMXMfxEGUKFpm2BnS/efecfpL65IYxvdCs4K
X-Gm-Gg: ASbGncvaC+eR9JMXPzyFvr2/rng1EJ6g5+azYO7jewp2Z9S437rjaQQSMj5UEskY/Bv
	tLckf3iQOTJ2GvQKAyV51berM2Zpbt7W7CYpkpd9rn9CNj6XtG+ei1IW2ppEr4Ue+foZSkngGK6
	zS4SHeLInBvUf+nRJ9OKMYJb0hqOXJaO9hBmxG5DoFOsgYJP+fI6JeTQ0TIqnmvWrfg9A2lQpxU
	dCv9MYx+1a+Llbql9GYurYxGnWShGyV7FtUA3bNpHGuzWYl3jFJgTl5KEDtAqR8W6htrX8lBN8o
	XAEvmekHbP/DMgZNRX97/7q9+qmDKrFKgdERwdgywMRw4yJS6s5dI6A4qPW+uxtRmKRDXTmYOIN
	z2Go0GyIjHHbcVR7Jkfk=
X-Google-Smtp-Source: AGHT+IFkMyymMTbmjIVjk2mrOuil/EgfPYT6sn+w0/OHZs5G4QDk4E2t8ponRzmEDowdEHWkiQCRcQ==
X-Received: by 2002:a17:907:962a:b0:afe:90d2:b952 with SMTP id a640c23a62f3a-b07c3512afamr889531366b.29.1757873116332;
        Sun, 14 Sep 2025 11:05:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd408sm781141966b.59.2025.09.14.11.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 11:05:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: thorsten.blum@linux.dev
Cc: brauner@kernel.org,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] initrd: Remove unused parameter 'pos' from identify_ramdisk_image()
Date: Sun, 14 Sep 2025 21:05:13 +0300
Message-ID: <20250914180513.1649962-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913143300.1796122-3-thorsten.blum@linux.dev>
References: <20250913143300.1796122-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, drop your initrd-related patches.

I recently sent patchset, which simply removes initrd support:

https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/

-- 
Askar Safin

