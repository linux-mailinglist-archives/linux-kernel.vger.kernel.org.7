Return-Path: <linux-kernel+bounces-735940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF2B0959A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760B91C4366C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E420FAB6;
	Thu, 17 Jul 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpIi95iS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7D2B2D7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783519; cv=none; b=h0/ff12gNwhUP+7Ze2K93OTkqVrcbnFZDXMvQoGby7BsBPbX3mPmQbnztWDVhnShbFqqGsO5GDhUJhxnOK7hbxe9AMtbvNglvBx6MEyJ8/nhPwPM9gz2ot/BcoaGiNKIUxnC+vH8uvQnXINFxTZSwLFRAkIuRB2Q8YRccwhny0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783519; c=relaxed/simple;
	bh=GVGGAnaBTRPh3N5XZAU1hTiUbtY7z6597U3Fs9b0VVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nih/6CaKhyzVvVbboqIcJ1c4nEVBe192v0XGaSNtm5UJgxoOUgVPZEsEI0XAelZ/Hu+jAqoBwBzM2dbb4j7P0jJY9KGg+ENLNcg6U9tZU85laOqwVTfVHzjkLpfVIWPC2wi2exlsO/oSXMLiLfuzHTfSNRcjop9gUH4t7l/LoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpIi95iS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23dd9ae5aacso12745ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752783517; x=1753388317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVGGAnaBTRPh3N5XZAU1hTiUbtY7z6597U3Fs9b0VVc=;
        b=BpIi95iSe4N7kKTfTGkpV8AumfPCzHQl7Z1SAy1f8xW56RZgIJ+PsISUyKFJNsR/Cy
         clzjO10/n7XsxAeSa5fkMRzVXnpPH2FPrh/xLRwetGM1iiWrRQimSQXoKrHCelpOcn8a
         1YbSliAt5JYAR/cBgrxrkx6hUNo2GXmgHdoig2tBnrlTlj4a64gV49kVNYQCDfuvoRuR
         YY0OXbiEeHLtDrVukBCK5nhjHWuLImnaB7x5WfG6FAriDrt5Z/atSqh536eSeQl/wY4e
         EZ5GdPA72w6V8tV85c/kzab39udSMefz3+u/KKqcWkwXFrG8nGEbbLckZ0RItcHstq59
         qjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752783517; x=1753388317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVGGAnaBTRPh3N5XZAU1hTiUbtY7z6597U3Fs9b0VVc=;
        b=Uk2JU3SiTaQGaFhzQNBUlLZiLfgxLPY868yrlDf/nBFq0AurBE/6ORGDorTCP5pGDy
         E6phmcXx8lmNKNm3/g96c8EfVnzFMHmR81W03eX2T6KibD9cCoQPKWqDWByQBiZDTNZv
         Q+aTGzKMnvy+UukFJtk5PXgTwnapJKjYfX2PfYPriAmgcfdVD1zoT59GYTj/ZF0RrzbV
         F17V828trA+RdD8mphdbVYWeH+hbLrmp97n7mdxrD6Jp2xMExbQ5McYKkyMankUBt2Hk
         rQ7kI3gv3lQzxCABU1xnYUKiLZ3CSaqeuShdQcVIMCYaINp8bpc7cK5GytlzpxaKYt9P
         oxYg==
X-Forwarded-Encrypted: i=1; AJvYcCUax+VCUV/909b1aPIgI0xkNUj8mUcn3Q4EMN+1fd1Uowsq/gYLVvU5GUmvhD6NVLL/npUNe7VPhKqWwqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoL/Jd5+ZO2jadd1YX9O15la1B1CxnHAaowTQ2JtR5cR9jgPA
	qbfl6TY2MNlou9QCb9qxKNN8n+rdPIYDzGqtcoLwIz8EXV/IVFhM7IBmVtt5r/hXlxIM9LLyws5
	xhEY2mePOZwxZrBfkXuYCySuIwXPHyEeKIgczELLG
X-Gm-Gg: ASbGnctlfaNuF5OyojB6PeIlAfu5gZXp/2qfNo1ZwRSA9e6nvTQQapCfYf+BIKjWoUm
	8lukBfY0jNkScCJRrnZlTmq2gGuH2y7PXiXofWqicxlStOa+eOezY8folIyk59KESxJYuUF850i
	ASpCbJudnC+Eq1v/IxwcqxfSMZxRRaQcISBked1ZnrrveNn0D8tc0ZRj0FGtd40rTWt6vaa9G9H
	v9oUUTATiwMqK7/9XZhuVpRkYsfwVs5XA==
X-Google-Smtp-Source: AGHT+IGHlzjh+Cc6nMPw4NREmZVHQGm7EQAmLmFok9RgzOB+vU+pnCC9n/9UP0d2BzdUpBuV4V06gJa5/PxJziH0CqU=
X-Received: by 2002:a17:903:2388:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-23e39227e02mr991365ad.5.1752783516719; Thu, 17 Jul 2025
 13:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717082845.34673-1-jiahao.kernel@gmail.com>
In-Reply-To: <20250717082845.34673-1-jiahao.kernel@gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Thu, 17 Jul 2025 13:18:20 -0700
X-Gm-Features: Ac12FXwtAKeMQOJbAIkHiXs4Kxx8yNT6FQ2wZ-vx_m9jtui3QP4tWcTFtOJXKgQ
Message-ID: <CAJj2-QFNvw2dMQtpZt1nHjKYdJWCH_=w2=2RWLL6m__MBb6KpQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mglru: Update MG-LRU proactive reclaim statistics only
 to memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, yuzhao@google.com, shakeel.butt@linux.dev, 
	mhocko@kernel.org, lorenzo.stoakes@oracle.com, kinseyho@google.com, 
	hannes@cmpxchg.org, gthelen@google.com, david@redhat.com, 
	axelrasmussen@google.com, zhengqi.arch@bytedance.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hao,

On Thu, Jul 17, 2025 at 1:29=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Users can use /sys/kernel/debug/lru_gen to trigger proactive memory recla=
im
> of a specified memcg. Currently, statistics such as pgrefill, pgscan and
> pgsteal will be updated to the /proc/vmstat system memory statistics.

This is a debugfs interface and it's not meant for use in production
or provide a stable ABI. Does memory.reclaim not work for your needs?

I'm not against the change; I just hope you don't depend on it
continuing to exist/behave a certain way.

Shakeel's comment is accurate. The lru_gen interface uses the internal
memcg id which is not usually used to interface with the userspace.
Reading this file does show the cgroup path and memcg id association.

>
> This will confuse some system memory pressure monitoring tools, making
> it difficult to determine whether pgscan and pgsteal are caused by
> system-level pressure or by proactive memory reclaim of some specific
> memory cgroup.
>
> Therefore, make this interface behave similarly to memory.reclaim.
> Update proactive memory reclaim statistics only to its memory cgroup.
>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

The patch looks okay to me too.

Thanks,
Yuanchu

