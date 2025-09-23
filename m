Return-Path: <linux-kernel+bounces-828833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECCB9593F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B55D3B42F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E71321426;
	Tue, 23 Sep 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9YOFtj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD72F6184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625840; cv=none; b=B2xXRAcB3EYQXQQHTlZA8JYRcQy1K6Ia6K71qaNvJk19TlDzS+aeIDy304fKqzogW9BwNQagPyH/J6ZZpSG4U9iCh+FDxA+1O72ubaiGeNIovF8zvJQVWCIUO3J6NIQzMA3mxMULE2nGhGpF7pMdeMkwh60oJ7B83q7Gz14ds1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625840; c=relaxed/simple;
	bh=wGRrexcrJiOYxex9LPSrvm70Gi0w/jmnAo5XesaOW1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzTh6M0p9pp9sXi8Awy9Hs17q1e91SERTSNaKkkUa1S+OoasLfh9r/OIJQtDJ29cbIlQselGCyEMGOfWnuNb1S+J0u1kGOUyxJJZrODt8zHzJwAbCAvDmSCa3cWB4GpXgBsWTIosBXNPbDp599LyVB265CqfEELNJ6BAFA6Qk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae9YOFtj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3264778f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625836; x=1759230636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=Ae9YOFtjcOo9kCmzREoCWChl1wKvUdJjZlm+TsEylERaa1L4kkSYi+K4uNEbWmLv4K
         XxmlPS0SsGU8mT51meZiuelPgpFr9j5DTe0ZuYhITHLvQQdjOpapgHuFPEUJE5Cfb5Ab
         L32H9SewvMcaq18c7QfR5xDiFytSw5K8ZkY1sJewx77eVR9wLuxCSl9NLsJi1+zCT3X3
         3IhXYZ/3XrZxcLudVDpJcGEWvGoOe0N7J6BLDsznSh1EIWBNtd3W7ZlBd3sBdPLU3M9F
         DC7z4SPl1R2nk1S4iSqIfvNxFz+k2eb0mL4fqiI7ZDUwwYfzNSfr+/DOHpe7D74Mx4Bk
         qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625836; x=1759230636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=l9sXn8DBYMeoN9de2CQiCrvZy+n8cGZW37vcI9A+MSCjl3dSsLrZGgRgd/+U1Wkff4
         xR+sFIlpDsNkg//MOeQfdTQb6G02tvF3uqXY7WdyKGk2rVj1RWByvP/1HDGfG8A4ao/h
         PNqDlQ4hBdPYzSr8EIs3dotS1vYyxggVq3PpAHsWeW02bqKoLw/XE7A1ba37VWnerCpQ
         DYhhNwFHcdfRWsTxm3NoCzqooxipfd0esfT6HIVqDNOZ4CDe9vyTYEPJuYh+OQBdyr5q
         sgU/D9sJgaojCfr1MaBG0F0JciRwNSi8L08dro6YJR8GdHvp385ZucJM/zhUadE/m6iB
         CGwg==
X-Forwarded-Encrypted: i=1; AJvYcCXyoUVe1Oxi0fqU7juoQo/Q8RQWkR16ijnPuy86alNSJm+ysao8HFO9whZ/GXN+9Ex4oH+jaoQXL/wCJ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5z04DuLiU2/HVpf3VCJsFD13cw3jpjZIGpNVLRepRxpXdkL/H
	unIQrOxwCa3OTA8xmEp5ujB6I2F1dQIp2yjh4lrKJ7dkNrch5ZQon9Dm
X-Gm-Gg: ASbGncvxhicCTpohCgXZO9id5i0dMzjqXzb2wMnvLW2c2uIHAwG/rM4PGGSggR1lwZc
	1wRQpMXJt7Jirf+R4UihhF/xYJy9ifW+w2XPACD6EOP0jjUnDodDvkMj/QmA9dFGl69k+sL/b/Q
	wsWnF1Y9Q7JLmTUCyqzpi5PMgeLGtMBr0mnflfBnwBi0FqYMYo9ykmvFcGvtMKjPaatpjwneHvB
	YwxyvEmX5xcRasBYNrylAij8jh2wcY379zSaDm3LNVQRrwnlYOLAvNVJdO3lRB+/c2mk5tJNujp
	vdh5J2kuKaZtdqX3B04I0LuTWAeKVffyVSBTNTfiXXw8ilKN97KVBx5t2TK5qb31hrtmSBXx
X-Google-Smtp-Source: AGHT+IHgMX3BiSNRvfrTGGdpNnaqqWvHnAmBH8PkRL8VnvuR0hyv/WFqY9PPvGGhOMcdRD/JvBVOdg==
X-Received: by 2002:a05:6000:186f:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-405d090c6d0mr2107024f8f.16.1758625836201;
        Tue, 23 Sep 2025 04:10:36 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm23503973f8f.21.2025.09.23.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:10:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Sep 2025 13:10:26 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-ID: <aNKAIsHQZySyrV4o@krava>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923092001.1087678-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923092001.1087678-2-dongml2@chinatelecom.cn>

On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> For now, fgraph is used for the fprobe, even if we need trace the entry
> only. However, the performance of ftrace is better than fgraph, and we
> can use ftrace_ops for this case.
> 
> Then performance of kprobe-multi increases from 54M to 69M. Before this
> commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   54.663 ± 0.493M/s
> 
> After this commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   69.447 ± 0.143M/s
> 
> Mitigation is disable during the bench testing above.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1785fba367c9..de4ae075548d 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				if (node->addr != func)
>  					continue;
>  				fp = READ_ONCE(node->fp);
> -				if (fp && !fprobe_disabled(fp))
> +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
>  					fp->nmissed++;
>  			}
>  			return 0;
> @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		if (node->addr != func)
>  			continue;
>  		fp = READ_ONCE(node->fp);
> -		if (!fp || fprobe_disabled(fp))
> +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> -		if (data_size && fp->exit_handler)
> +		if (data_size)
>  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
>  		else
>  			data = NULL;
> @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
>  
>  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> -		if (!ret && fp->exit_handler) {
> +		if (!ret) {
>  			int size_words = SIZE_IN_LONG(data_size);
>  
>  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
>  };
>  static int fprobe_graph_active;
>  
> +/* ftrace_ops backend (entry-only) */
> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);

hi,
so this is based on yout previous patch, right?
  fprobe: use rhltable for fprobe_ip_table

would be better to mention that..  is there latest version of that somewhere?

thanks,
jirka

