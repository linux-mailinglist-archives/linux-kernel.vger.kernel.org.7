Return-Path: <linux-kernel+bounces-860837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC7BF11CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 176CE34BA12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960B31353A;
	Mon, 20 Oct 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1cOESkD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1847311592
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962697; cv=none; b=GEgG+forgVT8T4nC7v9VOdwXIFdiZA9jKEHyq9W3R08KvFinb6tcL7idZL7SIROZTVFEfndPqEFN0qPNANd9G8TQgu1K3MIHvNl4s5mBmMUIt7qigRgSKuzTGNFYAWvf2MmUJeDNgPE/bOpudPJK08U1GkTOz96lpeFDca/YzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962697; c=relaxed/simple;
	bh=r0EfMT9X6rvzpWUrxQejrhPkjoIbmWaoix43K/pnhuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCVEZxAk3H08P5PmAQ53QoTR8eb4+q6YxK+RrVcPCeB1cmDDxHiA+8AC7phSjgrpr1L0L/hE7VqOiuFjfj6uhug8+eBV+JPHE1tlwR81nD3BRK2LInJuTf7B/re7AO1opxINmEfV3HnuIlHH+mQvXX6WolTtrFl0a9IzKBODzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1cOESkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A8EC19424
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760962697;
	bh=r0EfMT9X6rvzpWUrxQejrhPkjoIbmWaoix43K/pnhuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I1cOESkDtb6jDYTXLVe4Dl3S4aPAdgaz2tunhE9MAUX7pnxJ+zvtEzeHGD85fwSMV
	 wo4twoV+aRl5m0m3+J9sXf6CDWOFf72G5r3VRsSmmQZrclErGfuBw68qujzeO5sb0z
	 G7dXTs+2aVkxhqbeJg9aSqAVmxfAxA0XXYBeqO9K597f3qtyjryKf2oD5uHHIQQ0b8
	 OUz8Gi5QMy+AERiXtZ6H4sYXbTn8xIMK0nQSTWd09e1HZbRpbQtRI6L0Z3BPoPjsYu
	 wNx69wiqGIUi4RvL3weYDM6gU/kdjAT2YA7b84MaZDJ85S5pZe00hLDZhLb+O1kG3x
	 iMiZLMSBdxEWg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f86ddb3f4so1161166b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCjkt77XAICOVnHwQh2iAAyYpu56hyMIopRWjPeZYxiIsVLiHyKb17NRT1jDayX67bMD+kkm/297uHJQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCy9eHTZ1Jy86doHIaRE+QvTw385jpj7gbyx7J7LJdqYQKzsz
	X20ulrDUgQDKPlUcij+hJ+kd3aU4PdCLRbQyG3/eRYjMjYF1gFgNU45gtDiUA25ikh+2WboxByR
	tAoCLQiCP+ue+1yzoxn2XFgGinL9vPw4=
X-Google-Smtp-Source: AGHT+IE0I6W30GnSKbp2Erj/Uw5BnMxh4MvGbK/mgLcIWPEuN+PmNy1oBqcy5zKua0ICQgW7Xmqsmz8sxUjrWFBxnRM=
X-Received: by 2002:a05:6808:1806:b0:439:b9b3:af44 with SMTP id
 5614622812f47-443a2e20f40mr5745349b6e.19.1760962696808; Mon, 20 Oct 2025
 05:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020084429.230322-1-changwoo@igalia.com>
In-Reply-To: <20251020084429.230322-1-changwoo@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 14:17:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
X-Gm-Features: AS18NWDRFvBXPdetqSzpiuDZVc9Lq0RSEVb4luTn_5z_vJ4UDkHiWtyqqMdvrZY
Message-ID: <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: EM: Remove an unused variable in em_notify_pd_deleted()
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:45=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> The variable `ret` in em_notify_pd_deleted() is set but not used, so
> that it causes the following warning:
>
> >> kernel/power/em_netlink.c:228:6: warning: variable 'ret' set but
>    not used [-Wunused-but-set-variable]
>
> So, let's remove the unused `ret` to avoid the warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510151223.THlBK6QR-lkp@i=
ntel.com/
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/power/em_netlink.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 2c55c758de6b..48752189a07b 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -269,7 +269,6 @@ static int __em_notify_pd_deleted_size(const struct e=
m_perf_domain *pd)
>  void em_notify_pd_deleted(const struct em_perf_domain *pd)
>  {
>         struct sk_buff *msg;
> -       int ret =3D -EMSGSIZE;
>         void *hdr;
>         int msg_sz;
>
> @@ -287,7 +286,6 @@ void em_notify_pd_deleted(const struct em_perf_domain=
 *pd)
>                 goto out_free_msg;
>
>         if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
> -               ret =3D -EMSGSIZE;
>                 goto out_free_msg;
>         }
>
> --

Would you please fix the patches on top of which these fixes are needed?

