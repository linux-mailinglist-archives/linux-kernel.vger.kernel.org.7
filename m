Return-Path: <linux-kernel+bounces-745619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC71DB11C42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB7AC3F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57C2DCF50;
	Fri, 25 Jul 2025 10:23:58 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7891DE8A0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439038; cv=none; b=d41BaLffpYXEmvIEmoUiDPVKVWTiar2kLl5W7ZeWePszko2JwcbFVm+YT6ds/0UojEXYCLvcqiOqqRYgKQBNPAEizJcSrL+mE2j1o7ejubxlbEujjrSBHmQh0709ODT/jKOovqhue0dEx62VOoeaCOnCm0B9yMBwoD2+FfG1zYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439038; c=relaxed/simple;
	bh=VLe4sMrL1k7KWOP2jZiVP7tcDtRE+Qbc4qK2qla4WaM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hT/dhozzrG14yYPDVFzXZlUWs6ZjQA/uibsbJ1AHer07SQGYELVzpxCigt9DE31czII0EVDruFaCuCAu+vEjV9XtNmj04Ryex7OwVxUwp3ZeHgMcXDE4vYG9tty5mXXJdeO8qZM9xm7celH3xdiWnUi0QtH4mY4K0O26BzLlkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c7aacf746so126320239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753439036; x=1754043836;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/91LUBRWIj2RXQu76FiliIzwVQ3KuXlS2kWdoyQSZmk=;
        b=F1C65nbMnv/+V6I0egkiUi/UjBRvpq9pRaUUf4/xZffzvb1fb+FE24RTml4ysECBxI
         xGfN+eNN7pQoWRBzFP+kfXt1Z+YEaCsr/kQjcbHkJJihwjFY+6/zJSvj8EK9gGWKyGWs
         ILd/PHCFTHgn0d/jb1/XDNEZr27t7/QQ42qKR27QQcHtbtFb5sH70dAoWcrSAw3fRTNp
         92MMZLmNC51oRfUXkERJcLKCex4hjay+BQL2oY1F9MWccO5SZr4Axc/Dzlv2hLNLsOb2
         L+1tjAYWWjBrHgi/AHxxrQn+1PqjTb2OYFADlYnqvvE0/PLdEpB6ZolQNOImkyt7bggD
         dnXg==
X-Forwarded-Encrypted: i=1; AJvYcCUhXKtUWDHN4Mca8dHy4rH8Kj7x2FOHe8+0elERpQ2PA5gdFV9N/0/14g1qSmr8+4VTjjwnLYqhTEyK6fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKYkhu6/9bFRZC0hZ9q3aunT9c19GP7ZWdEhnpEPWvu7NwHa2
	6rLO6oq5jIvqetbCuMP4wECAG7rF7drD+ilzOiQcPn6VJe7PIh5Qzc1OdNmzqr8uOQejMMk/t2f
	wTGnISJCJY2bLJspg1El5gUAu3McXtD2oAyfNcWHzYOKmYbyQjb5usAF3ncE=
X-Google-Smtp-Source: AGHT+IFlvc8WmPZwrVwwYgmSZdkRxRNRAOuoZTYY4eZPe+qVgHELY+2xLDfVhvf34f2G40E6uSnx9jldM8r7dbznoPQaM5lViJ4g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b0c:b0:876:8cb1:a010 with SMTP id
 ca18e2360f4ac-8800f0ed0b1mr192273239f.7.1753439035967; Fri, 25 Jul 2025
 03:23:55 -0700 (PDT)
Date: Fri, 25 Jul 2025 03:23:55 -0700
In-Reply-To: <20250725112352.56640b40@ian-deb>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68835b3b.a00a0220.2f88df.0044.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insnlist_ioctl
From: syzbot <syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk
Cc: abbotti@mev.co.uk, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 23b7178522ae..360fde417016 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -1587,6 +1587,10 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
>  				memset(&data[n], 0, (MIN_SAMPLES - n) *
>  						    sizeof(unsigned int));
>  			}
> +		} else {
> +			unsigned int n_min = max(n, (unsigned int)MIN_SAMPLES);
> +
> +			memset(data, 0, n_min * sizeof(unsigned int));
>  		}
>  		ret = parse_insn(dev, insns + i, data, file);
>  		if (ret < 0)
> @@ -1670,6 +1674,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
>  			memset(&data[insn->n], 0,
>  			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
>  		}
> +	} else {
> +		memset(data, 0, n_data * sizeof(unsigned int));
>  	}
>  	ret = parse_insn(dev, insn, data, file);
>  	if (ret < 0)

