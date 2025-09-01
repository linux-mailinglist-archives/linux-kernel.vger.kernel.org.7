Return-Path: <linux-kernel+bounces-794391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FBB3E10D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C41F3A6C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64B31159A;
	Mon,  1 Sep 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2ep3R0e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19730EF7D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724858; cv=none; b=YdsY3+aLVfgJAh3IYPqXD/IY4A3mPLpY4hdr53jLE5ymVs6Dc2WYlJ8QglWYaoqblSxhgZGy6FQD15AYG88Z2sKkoVQwctIBILhkaoHRQbvN+cJLUXTfqYBYUfj9L13WQWlC9PpDYnF7+ClpnTiPrPu7mxE+kZLU+Csw5UAdAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724858; c=relaxed/simple;
	bh=tRPHUUr8jac2+pMZxNzhPsZb6N3jgXYWUxiG9fGUN9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nksyl3aEPHsDWwZMC+3WPtD6D/V0WKFU7eYWnVKicN4h94FQqHN4XxHgWOV2ehNOJaJMiGlxiMurJDzUW8+rLbIgHEt3S8mxpenYOyjotY3Zr2Qr9cvnh907o6BBlEnUOuquNA0RseEaf3h+8a+MM719NHDkamyg1yb1DxCq1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2ep3R0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756724855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeyR90kJgS2mYJEGVvh/bOgIfmtxoV36tSEqfoHaceg=;
	b=a2ep3R0efD4kHlPlLuvERcS5WKCfeMvpL/pZ0LQk/NApzpE3Qfi/+2wbwIaKzngqeRX1vL
	5gyTEsut8Usrs2MgYn7tlDjjLGVXAVbxXPGOatrkqqHm3vYu2XHeUC3AuQTAdkteol0d7Z
	0/hAqcVOU3Rw9mq9tR18UW4UEfJfWNk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-zrBD-s3hOUeqhiZz1miCHg-1; Mon, 01 Sep 2025 07:07:34 -0400
X-MC-Unique: zrBD-s3hOUeqhiZz1miCHg-1
X-Mimecast-MFC-AGG-ID: zrBD-s3hOUeqhiZz1miCHg_1756724853
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ccfd90630aso1805253f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724853; x=1757329653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeyR90kJgS2mYJEGVvh/bOgIfmtxoV36tSEqfoHaceg=;
        b=GxuY8HVo2VqV9MREeV8LjCA5aEO+OtIkRFHcksjqNVYyxn1d5Hr5VQp/kZxztLejdT
         qrW65unt9GWujcucoFaWJZljcw/D2Cap5Qk366arjP0j/a63XtsY/LnUsfZNcR3ppHjH
         vXYgRJaiE7zJg5LagrEzzmnOyrDdI2Nzace/5Fx5mxdkqpAMfyLC6RNEEaUWWDkamYfK
         8KgtIcUZHhqZNU8NNhpZqEaGjSiv5slfoJfrxUz0B+IJj18xq73qPtrGqn+GNIQBT6Hx
         7qLxIzfjEWkmfwtKS2PowUc3ur3cYzeMcqo2+2koim1KnEvCA87IFujjrvxdwhiqczNZ
         JM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjmNIqVoUogWVa8OSGepeQ+Au+Ij0aAfv+bljzlDXB42fD9kXR/3JU/ImB4GeFwKhfR1VdRluaAsQ7sT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cS9FXLCUogZUEq/c7hqw40Hn8f9IUbe7GElZMJn31ofdig0g
	hmAVW3kvpf4rj1VI0UDqLcl1STVc2MUfoD5F3BA/pxqAKWAYzeRcutwt+VjXHVLxpiz/4JuqEsv
	jzeP3izt/j5xdB9GzMSnakzMgmM9keO0zrdI65Fv6686oX/k7dFJ55dm3gsW5qj3DDQ==
X-Gm-Gg: ASbGncsgRYRLxqhI/PbyUGdoHth5vwmUK7hjr+eFxqv9FVuOrrwifR0heQC+HIZdH/m
	9GljdlUBaoOk0y1J8YpB0KyI9wjyyfkn2qF2LhrO8lQvklKaVyyCeC7Leml6b3LsWi1hkCl8Acr
	L2JLPOAiGSEoH+O0bi6LF7yXFKTCRkysf0OTm6UJ7ICHNZfEQczdOXb5vWaMA/p3QlDOj6T4Tky
	D/7Rebk46FpHK3roMvoY1BhYocucGQHnLpBqR/t8oGpWWc/sQn6qtgTRldXfFH1wQED6yc2Pbp+
	2duB+zMAlamzIgGa0ayv0WI+NLlAVL49+w==
X-Received: by 2002:a5d:64c2:0:b0:3c9:58b0:dad4 with SMTP id ffacd0b85a97d-3d1dfc06dd9mr5343788f8f.35.1756724852909;
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyQ/gTmJddE7MzkBzMXSEOkRhnYpYqf4H9E+J7ETOkCkNOir2xgQgyDgnguhb4xD0Yb+SJVg==
X-Received: by 2002:a5d:64c2:0:b0:3c9:58b0:dad4 with SMTP id ffacd0b85a97d-3d1dfc06dd9mr5343766f8f.35.1756724852520;
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:151f:3500:9587:3ae1:48f2:e5d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2722sm15020863f8f.19.2025.09.01.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
Date: Mon, 1 Sep 2025 07:07:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in
 __vhost_worker_flush
Message-ID: <20250901070709-mutt-send-email-mst@kernel.org>
References: <20240816141505-mutt-send-email-mst@kernel.org>
 <20250901103043.6331-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901103043.6331-1-hdanton@sina.com>

On Mon, Sep 01, 2025 at 06:30:42PM +0800, Hillf Danton wrote:
> On Fri, 16 Aug 2024 14:17:30 -0400 "Michael S. Tsirkin" wrote:
> > 
> > Must be this patchset:
> > 
> > https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
> > 
> > but I don't see anything obvious there to trigger it, and it's not
> > reproducible yet...
> 
> Mike looks innocent as commit 3652117f8548 failed to survive the syzbot test [1]
> 
> [1] https://lore.kernel.org/lkml/68b55f67.050a0220.3db4df.01bf.GAE@google.com/

couldn't figure it out yet, and I'm travelling soon.

-- 
MST


