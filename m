Return-Path: <linux-kernel+bounces-856884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA29BE5542
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4F744F42E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211AA2DC793;
	Thu, 16 Oct 2025 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y75nDUjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB541CEAD6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645461; cv=none; b=qdq+2NlstbicHFmifuP7W1SX2MpbOwxx4mbnjdmCRkp7B4lD7jLzeFrN4xHJkknbN2UPs9LjxHUfObayIWApPYzss8ah0BbHcSjgrMM8nvaZoZ2wx5qtRrifzt6ALHHdtgNH37VL2HeD38+YCzFhguitX44m6mnu4Bg6F4nb/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645461; c=relaxed/simple;
	bh=DmixuYzuaZh+vDqNf8iPdkYboIVzZSEBrk3DHQ8wFQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ0rtXDp5bY28FtoMALEAJ3keCD1HEyQ5rFeiqPc4aRePCKzg+4TcnvTfJ5gNnfoIPReFwYn8OZeo3j2ExQBsxG1ty+MJF++JnFk/PgW8IAKLIw7dNMKzT5Gsea3lyHKdZazVrY0ZLB+6KKcK0+JtDFrSaf18whonNSpFIXWHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y75nDUjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E356AC4CEF1;
	Thu, 16 Oct 2025 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760645460;
	bh=DmixuYzuaZh+vDqNf8iPdkYboIVzZSEBrk3DHQ8wFQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y75nDUjd0IwxG53dgKRoCIDiU7AV4ZnxtAUXX5XiBhXIT/Do0a0KMhRdK3gZLQe/s
	 CrKjDZKsCCnP4vye/0V2OLYviivfQXSc4HkvMZRN0+9DPMt65KhQq0W163WDEdlyM/
	 el92QSTcIcFDAlHSgkivQvvZGMy2IKVKzaJQ3E6TBuL+mZPQSLi51povt7p+j4ftJu
	 ArE3h29lOK5fOBLFt8ukRBNyumw90ngOIx7QeijmN9lJO9Aq6sraLISkHMrH4oDB/i
	 12QTDM4Cfa4XKZvecGsifr6zyQsakt3ti98PbAhmZ/qu8KQ7EY3LZyqqQt85Y7D53U
	 jdJT0VUxA8F2Q==
From: SeongJae Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/mm/page_owner_sort: add help option support
Date: Thu, 16 Oct 2025 13:10:51 -0700
Message-ID: <20251016201051.67097-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016054927.138510-1-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Oct 2025 13:49:25 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Add -h/--help option to display usage information and improve code style.

Looks good to me, though I have a trivial comment below.

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  tools/mm/page_owner_sort.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
> index 880e36df0c11..202eafed66a9 100644
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -669,14 +669,15 @@ int main(int argc, char **argv)
>  		{ "pid", required_argument, NULL, 1 },
>  		{ "tgid", required_argument, NULL, 2 },
>  		{ "name", required_argument, NULL, 3 },
> -		{ "cull",  required_argument, NULL, 4 },
> -		{ "sort",  required_argument, NULL, 5 },
> +		{ "cull", required_argument, NULL, 4 },
> +		{ "sort", required_argument, NULL, 5 },

Seems unnecessary changes.

> +		{ "help", no_argument, NULL, 'h' },
>  		{ 0, 0, 0, 0},
>  	};
>  
>  	compare_flag = COMP_NO_FLAG;
>  
> -	while ((opt = getopt_long(argc, argv, "admnpstP", longopts, NULL)) != -1)
> +	while ((opt = getopt_long(argc, argv, "admnpstPh", longopts, NULL)) != -1)
>  		switch (opt) {
>  		case 'a':
>  			compare_flag |= COMP_ALLOC;
> @@ -702,6 +703,9 @@ int main(int argc, char **argv)
>  		case 'n':
>  			compare_flag |= COMP_COMM;
>  			break;
> +		case 'h':
> +			usage();
> +			exit(0);
>  		case 1:
>  			filter = filter | FILTER_PID;
>  			fc.pids = parse_nums_list(optarg, &fc.pids_size);
> -- 
> 2.43.0

If you remove the unnecessary changes, please feel free to add below:

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

