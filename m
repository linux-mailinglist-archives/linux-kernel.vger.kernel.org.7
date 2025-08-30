Return-Path: <linux-kernel+bounces-793000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC7B3CB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235533A9DA0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D6256C9E;
	Sat, 30 Aug 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PzTO+rLX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498E253B58
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563295; cv=none; b=IgyXoRHY0wk7z8WbQqON/BCljBKuFSJeklpf5ChyjrJTod00GKvf/uYmvklApFZie9Bh3AiO7a4m8MNIib8mq5mdgetnvH6zn69/NQboukIu/r/en7doq1FHQdqw6VDVhhEkUMpLyvbsBVZWVzwRXt5pSEFReEhdgbD/TWwMRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563295; c=relaxed/simple;
	bh=NLarFhy3kQ/TjCF4gbAzrkvsWHYogEKJLhKX1GQRe6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WNrORXwclnsgqqJDrZ3Yoxpc3ehy01V0tC9b3LJuNa6XArYZPKAgfDJVZ8KSK+XqFvik6FgdsUyQ1Gphd+3Qg+VvuI8TzSNdqDxn+TMOuYtkn9VwdYqrIeODJGPGM9rsXVAoWDG7vk81Sp4ExA6b+9tY0PAAxYE090Qy5hynoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PzTO+rLX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770530175b2so2340689b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563293; x=1757168093; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=PzTO+rLXWFtNInMn5cl2f5knPnOvyE8e/ZqjD6aiCCgQ+BqEwHDYo2HM/3A5Bp3ZZy
         kYJ8hDu8Ienhgrt1uHtN16ectKQmQN08h8U2JrVHJuXTQ6jnCisyevIRb9LNG56KJ7oN
         j9nGMxcgPfM/4aK6n0gGcpk91LIAFAwD81DpLOkPe8CIUGHcG0gAPew+VP5xXWRp+/oJ
         13bFkvkb0Hk2b+Zp87AaWQUa4siq/7PfpHEC/vTtqCqxPZSIK7weWF5prqkbRimVzCQs
         1jE3rlj/30EYzDkgEAkf6paZLUkCmynYaNk/jQH8zHBcHE2K6C+gqg/WV6lz1lY/VXVe
         YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563293; x=1757168093;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=cxYMNBeaZuJ5PRLAA4GYeiOnM9RF8xT1bkIHTimD5n7uTveT8RLIaCqd6K5mnHpSA3
         o6ddRwuwrhtXuM4R2kxZsRb1jccVj8sWx75hicO1i9OkvlFA6o6dKTKc8IGG16URq0KB
         Oh+XDF9F3B7RxnfVUeuz1kwlhkgR7zMCtlFrDPNmSGi4a83PnIi5W3U2HBsu/hTgcFVD
         bGJj3j59GE2IUgdCfen9bW8mEARHGgFuVAYN1h2c4h4G3DGs3ODa2pGWiMeGnXkqArqD
         5Etb0pKGRZHcRA2HUbkjLR8DH1zcfY15ftMkVmapeNAK1581kfQfbRQbyU0ThnkspgY9
         5ypQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQgSqN6TtxFquvOVNU2dU7PoWYtr3rqVgORoI7NBU1d1qgil6x11m2lgDmXJR4W+0pypAdmSnxSc7zGyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLumRAc56KirtlmZgrXDk0rrXZaQc96k67FOZ0VPMH3M9Zoyt
	D7s3fYAaW+bBUc0hZDgd5DrTh/aUdOHtNx74OyJF0sUVMU2wIg6CPyeOXXzMdKnVSA==
X-Gm-Gg: ASbGncsgBSWfx5UaWD62YG135CNfMvV8YWU35MqNZL4CWSeGxq2nJDAuvmHhqwYKLkF
	TbVJTY7+6PvJwjq42QFRP0bL+2hl8oj6eJIa/Bzrjc89uOYwpjygutHO48sJdT/PxalRXdQFJTK
	En7n280ZSAVnZyLFMtno/HAkk9XXDoRzRLaP6SbPqlOBmmXg4cfwYlPn/5+NXy85Ii+hxAzhd9z
	5MGxYHIu+OHJnbMxlfVusmk9Q+sgXBmkryWJ/Z5VRTVdYXD9slU8PPyHCTULsiyiSmSgCKzhVl1
	c/jAEnoORFuiGCpEehJCwCV4pd+4rijoVefs7eegAhKFzrVK0xFIMEoSeU7aoyuiqKFgHabJ1sF
	ns0tdC9mB0GdMvg==
X-Google-Smtp-Source: AGHT+IGXGDxudBPOQGj+2n/Xq4JGPNY8rIEn5BPaZdBF3FLtxzrLU7/7VkCvAu8X+BdRWPuL6Qz8AQ==
X-Received: by 2002:a05:6300:210d:b0:243:966e:21a with SMTP id adf61e73a8af0-243d6f0b8a2mr3512373637.36.1756563293102;
        Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3296c8c11eesm1319169a91.19.2025.08.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:14:52 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:37 -0400
Message-ID: <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 1/4] Audit: Create audit_stamp structure
References: <20250816172859.6437-2-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-2-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

