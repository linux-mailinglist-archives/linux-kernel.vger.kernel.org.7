Return-Path: <linux-kernel+bounces-864454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B9BFAD47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34CE18C478A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BFC30506D;
	Wed, 22 Oct 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6vAg3qhU"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9B303C9C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120860; cv=none; b=uV2ZzmkAMj7pEIcDiuy8MpotKaLrjykmxHTELDteHyrtET+SekV3aohd8sqghb9RF1NWOgmdD2UF+SFERZIHnb8Es96e3y+gArVj+ffhrOmWWlD7FNrlT+yZvzPhgY3vf1wuABbd/IsLYQEDGlu3aO+3mu7Pj/uXd2kllgMyRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120860; c=relaxed/simple;
	bh=H9i6UoljCf2JzBJEdyRvJAkrbPTI8slSCJvsw63srs4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=brGGh+MzR1jPFmY0aPGNtcTvFBgFZDQmq6tdmpkymxcf88C4jxSjs2C+jGT48HZiS/gmjXg+U54/NZhmywe+dp73mru3ZO8sjaA5zdWwxgDMwDymgVecOqRISzzdCjcrTQFD7AFVWpsxDwUa5eadu3bUqbwrhtVIprLXIA5sxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6vAg3qhU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sNQMxguYxRy5VmNUSveNNzxqqUyeH9podY9lGnXUEKo=;
	b=6vAg3qhUDJ5RoF9ZrHjqd6OTnzE5kTGTK1P8PScxd7qM1jpEVufX1BeZjGuK6rFT2ptBe5o1N
	b1ukOcwKnq+sinNo39BtsoOHDTNy8ZFWy5DEG5d+d9LO88pFxPfTGjPv086xVgazz6EEMdcX+1O
	fsgwCaQi0Kt7Tz+YYrT6EoE=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cs24F6SgGz1prPw;
	Wed, 22 Oct 2025 16:13:49 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id CF19D1401F4;
	Wed, 22 Oct 2025 16:14:14 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 16:14:14 +0800
Subject: Re: [PATCH] ubifs: using vmalloc_array() to handle the code
To: tanze <tanze@kylinos.cn>, <richard@nod.at>, <hengzhihao1@huawei.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251022080200.526003-1-tanze@kylinos.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e345c2fa-3151-d8b6-6cd2-b0afd5e13d86@huawei.com>
Date: Wed, 22 Oct 2025 16:14:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251022080200.526003-1-tanze@kylinos.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/10/22 16:02, tanze Ð´µÀ:
> Change array_size() to vmalloc_array(), Due to vmalloc_array()
> is optimized better,uses fewer instructions, and handles
> overflow more concisely
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
>   fs/ubifs/lpt.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> index 441d0beca4cf..dde0aa3287f4 100644
> --- a/fs/ubifs/lpt.c
> +++ b/fs/ubifs/lpt.c
> @@ -628,8 +628,8 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
>   	pnode = kzalloc(sizeof(struct ubifs_pnode), GFP_KERNEL);
>   	nnode = kzalloc(sizeof(struct ubifs_nnode), GFP_KERNEL);
>   	buf = vmalloc(c->leb_size);
> -	ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -				  c->lpt_lebs));
> +	ltab = vmalloc_array(c->lpt_lebs,
> +			     sizeof(struct ubifs_lpt_lprops));
>   	if (!pnode || !nnode || !buf || !ltab || !lsave) {
>   		err = -ENOMEM;
>   		goto out;
> @@ -1777,8 +1777,8 @@ static int lpt_init_rd(struct ubifs_info *c)
>   {
>   	int err, i;
>   
> -	c->ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -				     c->lpt_lebs));
> +	c->ltab = vmalloc_array(c->lpt_lebs,
> +				sizeof(struct ubifs_lpt_lprops));
>   	if (!c->ltab)
>   		return -ENOMEM;
>   
> @@ -1846,8 +1846,8 @@ static int lpt_init_wr(struct ubifs_info *c)
>   {
>   	int err, i;
>   
> -	c->ltab_cmt = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -					 c->lpt_lebs));
> +	c->ltab_cmt = vmalloc_array(c->lpt_lebs,
> +				    sizeof(struct ubifs_lpt_lprops));
>   	if (!c->ltab_cmt)
>   		return -ENOMEM;
>   
> 


