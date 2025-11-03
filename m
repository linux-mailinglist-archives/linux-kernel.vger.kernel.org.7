Return-Path: <linux-kernel+bounces-882266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB950C2A06A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E9218855A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5012874E4;
	Mon,  3 Nov 2025 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzOuP+M8"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911F11CA0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762144056; cv=none; b=croLk4cPcOhw+MRl8ozixAEu2IbRN8y/WKeS+31i8/wkN5C/nFApBqzym67ugupJwS+AplUzbYv2GaX3PlFN1aEZbn14hp2XEulv8GGNckxw6SDYFjOX1T1HQcjbJrfh/a6B5f+ObnJSf91eFBSjqYHwsUCzWhZuf9FDcVsSW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762144056; c=relaxed/simple;
	bh=oVxmjux7xqyhNHNmfifSfarfos1FDqcCNsBOC73ekBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VmQzzgGpnW8+Y2LXmEh8muS3JIHLBfS4lYVWY5mMYHGg2pr3jWv9/da3xqe47pC/pKtZ1wQ7kzpeLQE5W2F4uXNwrnBKnmifn63Umi6rwmJ3yR/rePpdfBRZw5xdN3V4K1g601WO4ic42h+VUzq/JFJC120P4DCQbxABaKyovwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzOuP+M8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso657173566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762144051; x=1762748851; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVxmjux7xqyhNHNmfifSfarfos1FDqcCNsBOC73ekBA=;
        b=EzOuP+M8HU6V77Jz6YX9nDYu13DuTkx2guby9i1ra1bD9Jv3e4EM+ELchz+dhFH3v5
         5w4uz9Gh6szN0QtJIHHWJI77nfHtagcvhOBbaAjL80ZVs2lbNzxe662cUj4+SRIFJ8Ci
         cMznSW4vnSaAbI6Yt/iBPkUOHzQk+8G3H/H6uE/FEfksbRDnrbG6aXM93sFv28kZX1qz
         pc89eO+K0Ai9nORLnZ0gL/LOg4DJTcfmcm+bwSjei9Zfi/QwFJTS2vOjDU5a2snoD30B
         MxNVjYo6X1Vjf2qam8LA3qQ7dfdlVelXFrArNZP02Veqy1SVc/DxBKH7uvzxTb50wbOq
         PDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762144051; x=1762748851;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVxmjux7xqyhNHNmfifSfarfos1FDqcCNsBOC73ekBA=;
        b=uPcABi3ZLaJINAo/yOrGw3zG1QqzXnhKRWsYQO49GUiV3ZSpzs1+9M6MHhS8tJ+5Mh
         muHJosW6wD2a3bCm1Jfta/qqda8UcWFzeB8zK34YS7RsNKUY2c6ewoPBI8WE7n29SzJx
         Vbi8KWMWI4Evq7uvpMkM0ziPrdpzcxU8HTfEFifzp+hW8DkLDAhtc7N5sQ1YAamwOR1M
         XDbe9w8W406h3ZwyUZ4P6Sjw8wH1kY00hTuKonPA0WUUaTRuBLlrmYktq996VzBubtm5
         Z1Zuoccy8EIMtyee9FW1PEu8m35st+k+SZDcKtJaaUM7oGPxCPB6zE3uPY/dEYMk3qc0
         ZIfw==
X-Gm-Message-State: AOJu0YxO7S2NzVRbXrFDL9euemk7EiyHHABjLTOFvQL7xAPDVNz0Vd+/
	Ohhq2Tt3GLEUkRc4KoiqsjbXwnhrHdjMnN5ZFVs1wviT8aAEem4bHKnfLYhHaDRD1+9LYQa/VUH
	ZzNx5vNZhg5ncTljx/LLvs97qeoiQkyeQCw==
X-Gm-Gg: ASbGncvtS1BNI2k7b0yaBOec0MvRA6kf3k3foAZ4YeCK8Qi/gEv/VIBFVT8AiqMx0F1
	h1f1xQ1xIMAuZ+mkJSjZfb+BGYzLnvq0Or6dTDdwUqD3z9nHD8Ix+rE37ID31ehkzn3feRvyLEA
	TgMUu7jHiVIFWp8omJ3aXXz0N2/mdKfmn8tJwWK79Vh0DPCtpgybTKLYaRuiU1rYTyPsmRqzLlt
	Zx4xrTk6kcHDi+o7BSEad4OZ7WIbb6NGzbO8MSur3xIV4SHTltFSbgf2fdNkA==
X-Google-Smtp-Source: AGHT+IFwy+oEn6twPGLHn1HfSDdxfl8ZU6tctu7IVWkzJtkfXqNCs4Q1E+euEPLc23NSYpscIlRUzSlYSFowtoimIUA=
X-Received: by 2002:a17:906:fe41:b0:b3d:73e1:d809 with SMTP id
 a640c23a62f3a-b707061fd71mr1468587466b.48.1762144050749; Sun, 02 Nov 2025
 20:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pintu Kumar Agarwal <pintu.ping@gmail.com>
Date: Mon, 3 Nov 2025 09:57:18 +0530
X-Gm-Features: AWmQ_bmtzzfZ8ziVsRHYGwS4w1dORpOdFQuhDOhvEg35aIxdEL_6Ie7LjR-FnBI
Message-ID: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
Subject: Query: Y2038 patch series for 3.18 Kernel
To: open list <linux-kernel@vger.kernel.org>, kernelnewbies@nl.linux.org, 
	Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

We have an arm32 based embedded product which is based on the 3.18
kernel and a simple busybox.
We wanted to support the Y2038 issue on this older kernel.
Is this feasible
Do we have the Y2038 separate patches available for both kernel and userspace ?
Or upgrading the kernel is the only option ?

Thanks,
Pintu

