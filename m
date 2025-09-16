Return-Path: <linux-kernel+bounces-818679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFEB59507
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8363321F10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41328CF42;
	Tue, 16 Sep 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MX5mipFP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5A2D6625
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021777; cv=none; b=AE8+1RbgK27wjsvchVX55VPtdpf745NEzRqC/Y9EVZ/+jk2bo9hB8zUjxJLkwC6C8T2d9s/UJh/TQJr8l6pPjIZa6GvtpNDnn+geMaVY6LeJaW5f2igFN+l+LcYZ1BFgFldFjTWedClUNV+qk4N+2glnENF4/PacUnR/xGIjap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021777; c=relaxed/simple;
	bh=8kc0CeLZLfeiMXrcTaHIH/R4jGNR3faf9TtHlR/N16I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEMk9hhsg00zM1QgP4CXkHoJa7ljFeFpen1ixn1cr++jpKYGFENofgXheuicxuNgkLdludtfedjRc0LQGiqp0UjTFqYN1MLVPFd74k+lCj6b5rZmhRp09+SwYmF3ZQEHqyu8wuwA/eDC/M9dchS7Qm6ckMjAHUoopvMPPp/tWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MX5mipFP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04ba3de760so673400366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021774; x=1758626574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=MX5mipFPNTEeqUz+RN5Bk3CNl2bgoRjnfeBCCnTpnZwFdVp2AUHOiZB5H0MhEXFS0p
         Dvt4wNOou4O/mbc4KNwTzf725/3AzR+10Z/Qcf1YHf3+GoDXPsZAA24cPXIGn1BIYv6Z
         t5/mSgVHEEDywFY1wbDcY3Hb1953rwYazW+fsPy0nB1lOL6BezBABOug+G5K9ac9xq7j
         /fThtfbNmg5zXKaDBBNNen2pvJpT40RlTjRPTnRG6O8o7Ff8JZIBYug8kwGktm9+/wR2
         Rx199khf/PS2JCs1L38dFm1F/xyMrobmsqVS3sk7iFpjrENvMRV/2jQcrd6aJ41jYpaM
         15jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021774; x=1758626574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=Zq5DaN1dcgVMluks0bKYfCpMTiRoQIExnILdCPXyJg0Z+GIoqCZiMV7Kgqfdu0kJob
         w3CMCjZHIczRQnJCnJL2QtqmiTDwD6ubfDvMx4cSmzrYeV2XR0qUKa/JmgmJ0EQA+uRp
         tZO+3su6qKdmpY7hkvx0+jrTByS0ix8QOoREigo+90mXsFtfUpRFjFj+NtlSHrenK6A2
         aVJmWJC9t5NlPF0d3l0WFBzvpRB6JnEmI0cp3ierwaQMfT8GUq0KRFpp4S6q0jQujQ4n
         NMEgyocvt6OgQLoBJLIffevQDXWQmTEwhEy8PqcpJpRfS0q04lr9qQnRy9fEdWsXDoHn
         aF8A==
X-Forwarded-Encrypted: i=1; AJvYcCUxwTNS3qCl0vDQ2Z6ALtG0hByhDAmVbTP+WMlHVYrahuBQDDgHvEtbzs2H5H8aTOeWG1b8Mz/wR9P7Cfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsAOODkhIoqEUlfsskGtuPOONQoBroe1qtKzpr5DjNRgSzMH/
	/9F+5WS5x0y1RuxGGB+Cc1i8d8uATN+CbLCmmJpRY2gmto420kp+8pRBP9VmRz0x54U=
X-Gm-Gg: ASbGncvRUDTO8dseDTkJ7gRq/PqQjBzgLGsCaxIkZpfsL7xaQfikBBZY6VVEn84hWTK
	A+KuYDQoT7dU5JAGBD8xvhFToVUkCHlA4oJrFDZJ5i37U4I6UEqmcZzuDblBfO4l2ok5wX4PDxO
	zXxV2uw2ymrvSSAPwtQ0KxhaXLFqN0id06BvT18Qm9NfKikSMEGqFVA7pf5+VpfpG7xwXOJdujP
	mxkcdZyoxREgz21btEs5N4nS5vfsgZf9bFDe/nhN9Cu6s38jhF7qGXYzU/FvUfzwltVMgL/Iwj6
	wi2lq4G4kwfT5WXKL55SohXIg7acsmuRYFVZNHaBkuBx/sgewtucSOvcthRccKXXBmmyMkNLwA9
	fBsUkajxphj8u/NoidVzGFwCfbh7+P81Lut9e0qNMNNOlg7eZOmc=
X-Google-Smtp-Source: AGHT+IHgksZmCXWo+aWrU2puhznGEL5CDcY5xl+DcR6ldtoPz+TwMIqHuYXw60VG60pLkMPaI+rleg==
X-Received: by 2002:a17:907:daa:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b07c3574efemr1811450966b.17.1758021773565;
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm1157083666b.74.2025.09.16.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:22:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with
 panic_on_this_cpu()
Message-ID: <aMlIi9cT7xiYWo29@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-8-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:35, Jinchao Wang wrote:
> The helper this_cpu_in_panic() duplicated logic already provided by
> panic_on_this_cpu().
> 
> Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().
> 
> This simplifies the code and avoids having two helpers for the same check.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It is great that the helper functions were consolidated and moved
from printk to panic code.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

