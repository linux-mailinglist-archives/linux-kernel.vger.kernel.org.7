Return-Path: <linux-kernel+bounces-731103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E584B04F13
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98B117E3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27625B2E3;
	Tue, 15 Jul 2025 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zd6KwdYN"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3391DE2DC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550350; cv=none; b=rl5CFoAB4dhD0+jz/b0wYJGRbkWnzO5YKvAxSn3BWkRr50WjY84irZEJOEq5Z58nVcMMabigz7WCec1fGsVUXQjs8+qVReSdeqqao2sn0mosTKlAGc19m4qMsqwpuQYdDxOQCQ+nz51vJ0S+zcvJREV9V6wBSryauVpkwI8Y4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550350; c=relaxed/simple;
	bh=G/6Qw0QGoAHpeXel4/1om42k7CxgpeTGL+SaD4Vk6Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvzrSpMgdGqaQjZ59mGPOOBTS7rp7zkXg0x/DOSVmL/H67yHxYxwJa2Rp63nDa8+LaExiuipqvOeltZ82QUIwYrvFMNE2HOvqdbq5nFwxbHaXWLjvRe0YcWGKEwdzfPsJrjZjuJIg+vGkWYIiP/022WMbSlrgvPSC58J0xySI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zd6KwdYN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so4318223a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752550348; x=1753155148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wmdNxnEk7VZie3FE0SOO36LP3Yv8yGAzJzpW0/szP0=;
        b=Zd6KwdYNpsyYPCr1aHzzFiQo72thnB4ar23zKi/2/sC0mvN40QZj9JrUT65XP2tpMi
         nrOvoqPYpZRW2/B+eR9h21SZLkIwS10dGQ3GgEJE/QkYW7oC9L6o3fa+BmHPbMzGnfyA
         jzgG9rj54axqWN0i9qio2PYAiFwFkJfZXiNxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752550348; x=1753155148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wmdNxnEk7VZie3FE0SOO36LP3Yv8yGAzJzpW0/szP0=;
        b=M8Y/yTZXW/BD0GVH1rq2y/y/9rQPIte2nP8K20155h+ImGAW0ITfAm6jCdoPwl4TXp
         2NsHr/v6O9q0ZYfN363OOyD9i3rQWcbSK1fbtI4MZZAEBgdln/HHvf7YaqJ60YZA+C8n
         4Numh+GrvJaMPhM9CozMP7cdk6KZ/Y7hIbpjSF3lQIZaGMr8zRr1FWFsPkOpzyLu7XPk
         XlwqqHC40JP/KgdvVj3zkOV9TRwiLiWtmyd1yyy3FZZ8+HEbLxVnSef87POHvLdpSJXD
         U2L71gm/0FvbNG4T1/dhvzpLWwZ7Z9paj1JP/oSvXhzjpUTbRNjTni+G6Bjj8eskLc+f
         M63Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbhpfpRsn38xljGLUaZwOYm4CKrMfMS3aUoUgbY6iTObiUJzobReDoUXYTkixanKv8WSON85hLzRmfUqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka7fBad4GrLphSJOD4uOaFtk2gDt11dii5pud+o5JKrnBBVIh
	izMc80lMjnmj6c9JW3HAt4/lA+z/Ap+h0kTmA2x4155akB346bZMXOF8AU2hPHvBfA==
X-Gm-Gg: ASbGnctCNrQ4F4wHwmwzvgyHhnxhdocbGci1/xnF1E3nWKPfADx2P4FlfNSmDjwksRI
	4+fDdkQmQUZBTzA0vWBoCurLmFqDgy5uAqLq/WxpycsMQJjoO+1A69zMwtWBjAJEwA4Flfi/Z0p
	A+VC2HBDeP/pUui48SS2f1qWvZ3aw5kN2LCD77Vrca00NW/2XbFRGzxFAKE+HFrU3imZZ/XZBBE
	bXsPR8n0zejVCQgkUYJ/G5d8sO446D9oPK5lhjpuoo4WZEE0k8iBjxO2M3tzEI+y0nfGxZTSKTy
	Ax8pKqXx9uJdZy5T+lRvXWounvHkSCMupB+C8AcZ+n84vGvImeuDE7+//22kXwG+NkpFg+CHJjf
	WoOmme6QY8HdFEPZ3QnXz/yDfBA==
X-Google-Smtp-Source: AGHT+IGLTlrXC7/42TJknf9kXw9iX3FUKSUyJl557MuswCc1Ra7jelj5beeAq9knMgSor25eYQkwiQ==
X-Received: by 2002:a17:90b:578e:b0:311:e8cc:4256 with SMTP id 98e67ed59e1d1-31c4cd6303dmr21844455a91.22.1752550347853;
        Mon, 14 Jul 2025 20:32:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3e3b:c5a7:1b48:8c61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9159ec07sm305695a91.0.2025.07.14.20.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 20:32:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:32:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>

On (25/07/14 08:22), Jens Axboe wrote:
> This just looks totally broken, the cdrom layer trying to issue block
> layer commands at exit time. Perhaps something like the below (utterly
> untested) patch would be an improvement. Also gets rid of the silly
> ->exit() hook which exists just for mrw.

I don't have a CD/DVD drive to test this, but from what I can tell
the patch looks good to me.  Thanks for taking a look!

