Return-Path: <linux-kernel+bounces-826489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D30AB8EA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E85A176188
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4641547CC;
	Mon, 22 Sep 2025 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu7tvw2M"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C81339A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503218; cv=none; b=EcQUE7sZuco9MYEp0FYxmdSMMvmPkjNYvBBiacShOxJeRvBmW1NcwC1v36SUJRDaYgaLAR+L+i71sbKSIsjLLWws2fZdS3wKjQEU0ELg95Pyi7ShZKGDM4k91g31txvLAcAbJl7nOvXgm0yd3SJU0Y2z31OWKcmfKdfkPHithHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503218; c=relaxed/simple;
	bh=asv8V9+Gueu0sNN+f4Gl1Qt3MQgb39wz7+eIfVPVXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAHXk+xcET7wiNxBaX40UNZpeQHc1uTwWU5NwNcC/bOSDR0Jg7gBfXCmEgMpJMZgVWbWlvJnmBLQ9XRp60jSmBywGq3J0jrqw1Vx2FKjeYvpmhXvpsF8XiIqZXV52mRnhj3tPVPqMzUJQgaeIQHodXfmgOZhgDC+mkLCwib5vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu7tvw2M; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso3336167a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503215; x=1759108015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=Qu7tvw2MYaQL0yImQzNFv+BBEyaSNuF2pxV9fNky6RwH2DzTPNV5KcHGZ16sLApyrn
         agJukdp0o0We3p5OyBDueUIrnDoMk0w9qqC3CVi1wiVbgZ0jhDyYS1xasv6YyGV/X435
         ampdDzP96gOwodws6vcJq5XbN20F4N8TFwIbMYAIoenv8egSyAdV9Z7XugJGoBVLPP6x
         vX0sWgMA+v9lGWezkCzqO1MM2w27+1pNJKJF6WeQBmMBkC5pKrusxeEnHnYRXFkpvCG/
         ARcMFtExxR27sDASnmWXmJ03zYnoUpk8rOmdSg03uEu37hXsbYXYau2mnBS2KgU8Mkt2
         yyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503215; x=1759108015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=O0lghUv3c+OeSt0das9Q+ZHragAhY5lubdCgX0Kmmdj/vqWhQWX28ab06Osc0XB9Gr
         B0/PXTBht77sdUKv5TTVARaMAJQWGVbzOCY9YxpD/1X/S0KQj3HCLrn2DrjprAReijP2
         fdf/zFAff546SqdqT6PgXMf8CVm/ZDislxOx098jria5ebW6+LiDks1LpA8Q8fCMSMLi
         PaqJE3REJdnQOUU5Ov3XNY9l46mHDHe90vdNjS998xXA2cgeGYN3Ai89ZoSpjXleuyGk
         73UVQkjXzunbRAkd7Sclr4Lxg73M76ygisQ8JyJJzO+F7+15oEI32rhB2pGtY38Jb0jZ
         YDiw==
X-Forwarded-Encrypted: i=1; AJvYcCWxA/dUc+laD5FsZ/kigfVnrVBsNLm4PF4FB9AX0TOcSQ2RdXq1JSlw32CZtlauoVpQJzlHBHKJDFaEA1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSSLgSTkVtffz8Lo+OMXjs5NfEWySgmHV963poey1srmn8ZO/
	MP1eGxDCM50lsz4D7E/n19YJMocyto7+faHGc0MRCodi7r1ootWPnbEM
X-Gm-Gg: ASbGnctU4FpEi3buAQFIweuuzjyu+srcHuZNBcQs8AXttc7jz0JeTAaBEepcSgGhYis
	HxcR4Qn3PZAabpfthwlqoeE/w7mMOWrag2OCsPhYWtGQcrpgjhy7tLrITi7Q14ZYdfJm3CfWsgm
	jEz364ECH5HToOx3f61roByJW62JF1cklNcCzczvaChKEO3op+qcdOO07ABDIEWCxjpg6Nia7ej
	U2faRJJiNCnieL9c2UmnqIJwPV2C4uvzDzzvsL+1Hv/Cb/pIPWHpkecZ+Xxpt8+Z7iIjoRDV1rV
	Fwg1y8P0ihVpwLnKXTxxjviqoNLrSvVMg6NAPcFe3tIxYwh1gYn7AWtYkftSM3JgW6Xa3zDZUfq
	f9aKDAOnnZlZNR4WsKhc=
X-Google-Smtp-Source: AGHT+IEE+dlkZ61hvZbcIoJcLnr6qbKVmAfG180HpIGplBEyYngiA6LG2BlkeTTj4jLmF3uK23VJkg==
X-Received: by 2002:a17:907:3e17:b0:afe:74a3:f78b with SMTP id a640c23a62f3a-b24f6120e79mr1092368266b.59.1758503214799;
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b264fc793f4sm640643066b.17.2025.09.21.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
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
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction
Date: Mon, 22 Sep 2025 04:06:49 +0300
Message-ID: <20250922010649.96399-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Some mount attributes (traditionally associated with mount(8)-style options) have a sibling mount attribute with superficially similar user-facing behaviour

"Some mount attributes... have a sibling mount attribute"

Something is wrong here.

-- 
Askar Safin

