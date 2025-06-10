Return-Path: <linux-kernel+bounces-680083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149BAD4016
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F331896ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDA243951;
	Tue, 10 Jun 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="R+fm+0na"
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A365242D73;
	Tue, 10 Jun 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575414; cv=none; b=bCUHs5VZBTg1mvzl30lRkr7JcVVvLrcp6uLW3TjUhKBkdN1wdVs5PQNNne37RqPc5urUow+pbCU+hxAF69HjqDTFJ8tNm2CVoVSIRzzMdtgeBBOESoRyZ9utBq96z1a5VmD/ghO92t8/rBtPtZjF/mikOUFmpF3V9V1uxEMw7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575414; c=relaxed/simple;
	bh=xtYL2RK0te9ZlBj3m+Vb6eAvKD67QR1pu+qsBXUhyOQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=jEXBvWLgOtyQ7znwAQP5TfTj4/vnKcDU5uGNWVi2YuBAQo2boQXb140wdb4Wr1nWg6XFSBZl7yAEdj6pj4rYlI2y6q1GNviDXsmJ2/VJYKPQ2TPIYb7s51sveUm6lbcTNgBHwewIPipWFKeyIu7JlkxkSdugPebFm3pXIp/sIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=R+fm+0na; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Date:References:In-Reply-To:Subject:Cc:To:From:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xtYL2RK0te9ZlBj3m+Vb6eAvKD67QR1pu+qsBXUhyOQ=; b=R+fm+0napNWOeqakU+ktfbxl2P
	b4IrPYroXjNRVdU5HTzMhfueVY6AmUD/txDlE1eMcf/BpS1VIvgZ3IENYbNpCItUNy2r+nls+DmKo
	+u7DlBkRwrD+q9DxTT2729nWsto0ejANn2M4bN8EVrisu2a/PpRqKt18+eiq+q5n3sLfuj+aPQ8mR
	IXTszQ+iZFuk69V6gWhYyynNlFkA7asy6xfTRYp3+IAB7v/KBkE72z0WH1jRDsoYYEOy+XbCe6FFa
	23K6QW9lzBdxE1e5vI3bY3Q2MUyM7/vthb0agSW5FSFfvLb+G3hH4uuZbkCQEyU87o3HhfWwgOnji
	qnY5OugQ==;
Authentication-Results: mx1.manguebit.org;
	iprev=fail smtp.remote-ip=143.255.12.172;
	auth=pass (LOGIN) smtp.auth=pc;
	dmarc=skipped
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1uP2U5-00000000Bnw-2uZz;
	Tue, 10 Jun 2025 14:10:03 -0300
Message-ID: <b51772c542618b56cf0fed0cf95836f5@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Tom Talpey
 <tom@talpey.com>
Cc: Steve French <smfrench@gmail.com>, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Show reason why autodisabling serverino support
In-Reply-To: <20250610165555.sekma4ybcl63flnw@pali>
References: <20250608164453.6699-1-pali@kernel.org>
 <3d644c3f8acb3dbcef395bd96e7e957c@manguebit.org>
 <CAH2r5muuanOgjzQ8wgd+QoyrU_ZM4tATrfYYQj=b7MapGLMh5A@mail.gmail.com>
 <20250609073650.kj6lxrykguhb7nuo@pali>
 <ac80cb46-5787-4fc9-a405-fd38a505c613@talpey.com>
 <20250610165555.sekma4ybcl63flnw@pali>
Date: Tue, 10 Jun 2025 14:10:00 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 1.1 (+)

Pali Roh=C3=A1r <pali@kernel.org> writes:

> For sure I can improve also existing text message. But Tom already sent
> NACK so I'm not sure if I should continue with improvement or discard it.

Oh, feel free to continue as I'm not the CIFS maintainer, so my NACK
doesn't matter much.

Go ahead with Steve's suggestion to make those dynamic tracepoints.
These VFS messages will simply flood dmesg when reconnecting,
automounting DFS links or surrogate reparse points -- note that they
expire after 10 minutes, so next access will print the VFS message
again.

