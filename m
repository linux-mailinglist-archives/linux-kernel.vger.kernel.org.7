Return-Path: <linux-kernel+bounces-884743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62610C30F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDC4257C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905382DEA98;
	Tue,  4 Nov 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="X2dxo9B9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8827470
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258829; cv=pass; b=V2AwV1SVu9U0R3CbvUAJ1XDYH8oaBscokdSLfWpuHvsGRR9mzsdzi3F/W41b/dZtZXHbGQtyca+f2ETHmWWVX7zS4tbJT1fh2zLKs613BHxIC3YT/1q7hI/l0pr5dfWSGHBgp8qDhvhAhYZI6TWF1UV0bPr3LjL3udKRSHBSGoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258829; c=relaxed/simple;
	bh=h5ZcPfEqMOwPuNRywWo0PRdQKYd5j/22Z8fnjsML0o8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TOOqah7S42nC0cnfc/Iq/RR/topxETfNwtUDvuKhhDCpMKnNGqv5h77txbQcaod/W22bVSdBFfl7oTGnAI0hBBXKk2UN1maZ0ELMXqAtLNOeOY2VbQ3s1MVNfrCI6bJrPlCwi2Dqm9gem+fEYY4eh2YWk4xpNQ6l4/oj3ZnIxYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=X2dxo9B9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1762258786; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=An/qAk3ytJUIkd8Q5APL3xktI87t0fa/aTDj4lGDfLDxDAdNq3uGSicjFkctfyo/qn2vYKUVjWlWUGwOWDqrZsrVjviooKLVWovcz6fi9eSEtDC9YBKFxAUTXLkGpMscoM2f1dMjY/+NwIM/aYdtwq02X4McRkdmqlJixYPIDtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762258786; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TDb2puPoWZ4O9gbvaHCNjq9xOPxxImL+E7UZU/YNZjM=; 
	b=oJoAcnKkMn7u6B7qQgZLlyQicrhz9aj1Ktf5+o8MUujLVJQoatK0gM33sohVIg4rSoUl2qOX1YLCtZpypgC/nJy+G5Qrlyw4ivHevwkdA6hG9xfUjX4QqpDxmSgxqesF/MrTDQS3P77OM6HpEeEwDvy6gtd68n4NE+Uu3kIX9vE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762258786;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TDb2puPoWZ4O9gbvaHCNjq9xOPxxImL+E7UZU/YNZjM=;
	b=X2dxo9B9duuYVoHX3IZOQiJzgt0XtbCsk17YCThUOUXSQgkThXMkeohxSfNJBQlH
	WX6CVwaBpHVLDrKLcHe7KPCqUeILx+zwJ7Ha0OyEXdXrqD7dJE7iGZi7b/rxzAieMxb
	8fsXiETWqOieZ68EWEOMJS9/jXzX1vU0an+0igN0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1762258784610216.74943677819874; Tue, 4 Nov 2025 04:19:44 -0800 (PST)
Date: Tue, 04 Nov 2025 20:19:44 +0800
From: Li Chen <me@linux.beauty>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>
Cc: "dm-devel" <dm-devel@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Dongsheng Yang" <dongsheng.yang@linux.dev>,
	"Zheng Gu" <cengku@gmail.com>
Message-ID: <19a4ecf1149.3c8a574d835968.4993900419375442453@linux.beauty>
In-Reply-To: <20251103113803.00001448@huawei.com>
References: <20251030123323.967081-1-me@linux.beauty>
	<20251030123323.967081-4-me@linux.beauty> <20251103113803.00001448@huawei.com>
Subject: Re: [PATCH 3/3] dm-pcache: avoid leaking invalid metadata in
 pcache_meta_find_latest()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jonathan,

 ---- On Mon, 03 Nov 2025 19:38:03 +0800  Jonathan Cameron <jonathan.camero=
n@huawei.com> wrote ---=20
 > On Thu, 30 Oct 2025 20:33:21 +0800
 > Li Chen <me@linux.beauty> wrote:
 >=20
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > Before this change pcache_meta_find_latest() was copying each
 > > slot directly into meta_ret while scanning. If no valid slot
 > > was found and the function returned NULL, meta_ret still held
 > > whatever was last copied (possibly CRC-bad). Later users
 > > (e.g. cache_segs_init) could mistakenly trust that data.
 > >=20
 > > Allocate a temporary buffer instead and only populate meta_ret after a
 > > valid/latest header is found. If no valid header exists we return NULL
 > > without touching meta_ret.
 > >=20
 > > Also add __free(kvfree) so the temporary buffer is always freed, and
 > > include the needed headers.
 > >=20
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >  drivers/md/dm-pcache/pcache_internal.h | 13 +++++++++----
 > >  1 file changed, 9 insertions(+), 4 deletions(-)
 > >=20
 > > diff --git a/drivers/md/dm-pcache/pcache_internal.h b/drivers/md/dm-pc=
ache/pcache_internal.h
 > > index b7a3319d2bd3e..ac28f9dd2986f 100644
 > > --- a/drivers/md/dm-pcache/pcache_internal.h
 > > +++ b/drivers/md/dm-pcache/pcache_internal.h
 > > @@ -4,6 +4,8 @@
 > > =20
 > >  #include <linux/delay.h>
 > >  #include <linux/crc32c.h>
 > > +#include <linux/slab.h>
 > > +#include <linux/cleanup.h>
 > > =20
 > >  #define pcache_err(fmt, ...)                            \
 > >      pr_err("dm-pcache: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__=
)
 > > @@ -79,14 +81,17 @@ static inline void __must_check *pcache_meta_find_=
latest(struct pcache_meta_head
 > >                      u32 meta_size, u32 meta_max_size,
 > >                      void *meta_ret)
 > >  {
 > > -    struct pcache_meta_header *meta, *latest =3D NULL;
 > > +    struct pcache_meta_header *latest =3D NULL;
 > > +    struct pcache_meta_header *meta __free(kvfree);
 > >      u32 i, seq_latest =3D 0;
 > > -    void *meta_addr;
 > > =20
 > > -    meta =3D meta_ret;
 > > +    meta =3D kvzalloc(meta_size, GFP_KERNEL);
 > See the guidance notes in cleanup.h  THis hsould be
 >=20
 >     struct pcache_meta_header *meta __free(kvfree) =3D
 >         kvzalloc(meta_size, GFP_KERNEL);
 >=20
 > That is the constructor and destructor must be together. Inline variable
 > declarations are fine for this one type of use.

I appreciate your suggestion very much.

Regards,

Li=E2=80=8B


