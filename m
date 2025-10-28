Return-Path: <linux-kernel+bounces-874840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE37C1733E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 172663564D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A53563E4;
	Tue, 28 Oct 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oswcsXZG"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0F350D44
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690858; cv=none; b=av5T5CpzKBl779ZPNJd03pRyjh83rNEV4FfIoqZrVjf3/son2BmlfELJfX4ANs2pdX/CQeKZzngBF8lWPk4HmfwZliXjRJ7oUBNXDbhe1WS1eUZeRN0KPBd4SBtYyJFeoRqvnBS14UeNza+vDAG6s8X+cJYVN6EtTrPQd6CxGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690858; c=relaxed/simple;
	bh=u8baRSL7KclzTL8WlsWeWbaoI5oWwE3of0QEMtKoYGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KrjxRq+RyCbYuxuYin2W+OT8DrFBZgrrwI8miMS2jzhfuokk62qWPEII8drNv+F57zshFR1m4/ASAtW1bR6Jb1YJ2wdKJhLepHyAZAhbT5HBejL2DkoRflOD1tGn49hk2CA3I7M2erRdzWkrhSCCRsxdeY//GGaoNAXGnstPzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oswcsXZG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-783c3400b5dso3750924b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761690857; x=1762295657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=82B/e5OUffQkDxAP5PsiVgukJ2nGDysFGKTvJ7FhReA=;
        b=oswcsXZGNealMx4g4hb2TEsND2qSuqcSWGayVkSyYQa1uhWhOVmycNztrYep4FHhmu
         RcdoyqQxepA3tezrmrSdtrEpM8qThI9Dz7dPynzB5wLpmD5FTjbmuf5AIM9BEiJj5/bH
         05/xunhfyL/iH+aYlDoMhCKEOnJEg0r9DpPLyi9hzYPSB3AX1xu2UD4f9MpXwIhQ/EtB
         P+Xd5uOAHsFr0wnzLVkHlU+Iw73OoqLR9H6TDp/pYiBc7Zo3ZIpKA0PAq/Uf4rg0H6rD
         IB51SEIco/uVb7RoFJDD8QFEkGMnlbnwHcxvaFi4th7d3Q76tgy9yiqNEtP3QqBeN07t
         4/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690857; x=1762295657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82B/e5OUffQkDxAP5PsiVgukJ2nGDysFGKTvJ7FhReA=;
        b=ZA/EdSNniwVEyQWAgSzTWBuGUHjXOAxtx5r/TBKtYc1vjHry4BjpskHPmMHctFTW7B
         3Fmqq0+JfU4dXjGvxmisF3ui/EI8MsxPv+MU3utfnNeYSabhwrpvso786k0EA8v9Dsxj
         RfUrtOwh/69MVtyCORXkkTHTvn+tS7ARynK8lBa/UDldhnRhNP4QrTDwJFhwgM0LqMeP
         1YptxdETFqa0VfA09lMjTTJebkodXreld6QHZjAgMjLo+SJxISDTrwQv1CwnUZuFxY/a
         nkdGeSQq+kkfCj6ZlmUBQDBQaB/FBhNJRSTMgPTyb0Hx1Sl9UosgNyYEkvTSNt611WVm
         gdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwM1wGhoCP/dpuAsSR6SDBhWWI+iWOUzW+uGnGjmf8reSXS9DLB2VFWbetYqdZ13hlnycEgMsCFQnfegs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sJtNi3/f7wraY0a0N2SFkA/53u/279TDpz2po3CiIfPnhfFi
	uY/Nk+Tkmrr6tsT+HZhWvKh6O4ef/YtWuag6nFYK1sUs+cr587sa/DMaYXZ1OB4wkQWbIbDJCo+
	0VNX65cY6QRJFToIrFc38kUA6Kw==
X-Google-Smtp-Source: AGHT+IF/qfPNoL6JkiLjO359CkzK4oS1vbBtwFq+LTrilAHtRFpRVvqvS8ZuclUXWTGo1CNzmGf9dAahO2M+QJlTeQ==
X-Received: from pjph17.prod.google.com ([2002:a17:90a:9c11:b0:32d:7097:81f1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c9:b0:334:a784:3046 with SMTP id adf61e73a8af0-34653146b07mr765020637.38.1761690856743;
 Tue, 28 Oct 2025 15:34:16 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:34:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251028223414.299268-1-ackerleytng@google.com>
Subject: Hit an assertion within lib/xarray.c from lib/test_xarray.c, would
 like help debugging
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Hi!

I'm trying to use multi-index xarrays and I was experimenting with
test_xarray.c.

I'm trying to use xa_erase() on every index after splitting the entry in the
xarray. (and I commented out every other test case just to focus on this test)

Should erasing every index within the xarray after splitting be a supported use
case?

Here's the diff:

  diff --git i/lib/test_xarray.c w/lib/test_xarray.c
  index 5ca0aefee9aa5..fe74f44bbbd92 100644
  --- i/lib/test_xarray.c
  +++ w/lib/test_xarray.c
  @@ -1868,6 +1868,9 @@ static void check_split_1(struct xarray *xa, unsigned long index,
   	rcu_read_unlock();
   	XA_BUG_ON(xa, found != 1 << (order - new_order));

  +	for (i = 0; i < (1 << order); i++)
  +		xa_erase(xa, index + i);
  +
   	xa_destroy(xa);
  }

And made a call to

  check_split_1(xa, 0, 3, 2);

Here's the assertion I hit:

  node 0x7c4de89e01c0x offset 0 parent 0x7c4de89e0100x shift 0 count 4 values 254 array 0x55edd2dd8940x list 0x7c4de89e01d8x 0x7c4de89e01d8x marks 0 10 0
  xarray: ../shared/../../../lib/xarray.c:764: update_node: Assertion `!(1)' failed.


I think I've narrowed down the issue to the for (;;) loop in xas_store(), which
I believe isn't counting the `values` to be updated in update_node() correctly.

Is `values += !xa_is_value(first) - !value;` intended to compute the increase in
number of values with replacement of every slot being iterated by the new entry?

Why does the computation of `count` involve next and entry, and why does the
computation for `values` only statically depend on the initial value of entry,
and on first instead of next?

Thanks,


Ackerley

