Return-Path: <linux-kernel+bounces-643167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB2AB28F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC83175EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB446259CAC;
	Sun, 11 May 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HR6iB83y"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83578F39;
	Sun, 11 May 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973376; cv=none; b=puenBZK4GNkUuZft2hz5zOxQbVKs4cd854o63vESmXC6TA/WBXrVZtqpEmealwJ7Yqdl90gpe6yyuZm0N3Oo9JnvuYJV7BEbV8RkYxfrwLBAG/ZajpYNVnGqiR0bWPao6TiXwoU6HLL9d/M/qpkNcYidFuHuEAWcQBUypw3oW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973376; c=relaxed/simple;
	bh=Cvso/ueR+eQJGqbU8rPIQavb4IEGDWDqZOvGuyA/txM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X98OwrkSX+4WB6wyPnhFlSulH0+mHmByoYoD2gxdbKp7b5iZFM3pyq90PmfieMzMx0e/PYG9nuRVSVtEZBBqLjy6lpRSkP3HYv0E7zs2h6KO6PGaKlh1LZdFWXUkkudfo3RMYd6Fi3cjfnmqR4XlNoFtq8xv9w7/a7J7yCb4AdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HR6iB83y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dl2/kCc9M4N4J90OTO9l5W+xhhLbQekv5wqx/NolqZA=; b=HR6iB83yM4dRJGCTEIC3bSTqno
	iFj7YbvxN6WWBI6gcr/HzXQMY89x84JS9EgrdgpNLazEXz8bBsuBFynkq2Wo9JDexP78D5dUoyRSw
	q/QkTAkYgxHZ2GnJnULFSbNrMECnHj3SoBqc5gse6FgabX06Lh7kLf2AWICJMHOt1OI8k6MIDLMAQ
	pBlXnEZ6c9Q0fE2R408AY2gqYWv8n5i8VJQBS/lt7zaruo0aTZgTv/PW3LfDilQgUrjifKOXGWAhO
	BvtDExmyPAm8X/W26tJncOnDgMTtLBDTdRuOpSVzdI2UoXUOqcX1qkbg0l5NS00kciIXUig03n9Yv
	yHAxKy5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE7Zd-00000009Vtj-1idK;
	Sun, 11 May 2025 14:22:37 +0000
Date: Sun, 11 May 2025 15:22:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: WangYuli <wangyuli@uniontech.com>
Cc: brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
	tglx@linutronix.de, jlayton@kernel.org, frederic@kernel.org,
	chenlinxuan@uniontech.com, xu.xin16@zte.com.cn,
	adrian.ratiu@collabora.com, lorenzo.stoakes@oracle.com,
	mingo@kernel.org, felix.moessbauer@siemens.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH] proc: Show the mountid associated with exe
Message-ID: <20250511142237.GA2023217@ZenIV>
References: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 11, 2025 at 07:42:43PM +0800, WangYuli wrote:

> +static int proc_exe_mntid(struct seq_file *m, struct pid_namespace *ns,
> +			struct pid *pid, struct task_struct *task)
> +{
> +	struct file *exe_file;
> +	struct path exe_path;
> +
> +	exe_file = get_task_exe_file(task);
> +
> +	if (exe_file) {
> +		exe_path = exe_file->f_path;
> +		path_get(&exe_file->f_path);
> +
> +		seq_printf(m, "%i\n", real_mount(exe_path.mnt)->mnt_id);
> +
> +		path_put(&exe_file->f_path);

Excuse me, just what is that path_get/path_put for?  If you have
an opened file, you do have its ->f_path pinned and unchanging.
Otherwise this call of path_get() would've itself been unsafe...

And I still wonder about the rationale, TBH...

