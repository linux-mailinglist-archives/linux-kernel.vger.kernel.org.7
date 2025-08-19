Return-Path: <linux-kernel+bounces-776419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25279B2CD12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19A4B4E49EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCC33CE96;
	Tue, 19 Aug 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxeatVFY"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75330F809
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632295; cv=none; b=Qt+QAKA7NTzEva8lUj7YUIOQJXVawj6J+Y/6U5a9LknJcyGCgzH0/hwNtlM0fLkCzwzAFgQZYT1a7UmqI2Y91vTKPsA7/zIecDzRvcrRu6yvgNDgML5uaYYIL/jja3vsFD04j9jze/SjId1u2CDT8+ywYx8BpXKURYGcJIZ2CZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632295; c=relaxed/simple;
	bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is8T544zHM499Jquy89LjxBZjxrwUX5wmQaHElJBi/c2ozZtWidNuVvn18fGSkdL+7B0I/vEL5xtXj4qwfEo6IFdsWbXx9MvYCQyIJKCdpTO46y3idwI0in0NCtigDP5PdJPhmRhSU6LX/g2ocuomHySG4TiaBUQ6Qg1pF/rfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxeatVFY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0bf08551cso101361cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755632291; x=1756237091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
        b=BxeatVFYwJ0DeTiGmhhmBYqyBFhikIt81fy2+Ff1GvRp79lzzGu1mbPpGJo61+VkFC
         ZdvMQpRJesWHpwqk+RroPOrAeIT31K1mmGO0cyA0Co/Fu7qGImHHd0KDJHBwc4gbQPKN
         9mxiWdJIV3MWZGoj+2pHUXagAIFE210LOSz4dVYSYkdJSIdHlEFCAWgW5MciycAmvdwJ
         BM84s7S8Y4cvEnc5whvRBWbuRIxoHWl8Au41Tae5d3Mpfz9pSE6yPqmS1/ESeUFIw0ia
         vli+xZB6Gp9t92RJO8J1FZrEMMkAjeWqspmpt47m+6wS8eaB3I/JixMp6BXQuxXMeBBf
         4IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632291; x=1756237091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
        b=hD1x7IWJq4hyaktU/aF4EdA5UOs1GELE5eaDPv+ym1atffbcWnwbt15j+5j4lxPB07
         gW8nmwA2jFZoVg8MVaSqNFtY5NKWlVU+kDY1xC9YvMNZwC/pATj2PKR1q8Gs0AELO57q
         z7xBnSewqGQV84dgO3LO5XFFvyBWuhWCCiobhGlCF6cDr0bq93JGpNqfEZQqchoVGwk+
         pgB5S2lbaNzLIWdBrhKJzHTm8JP3cdsmcgA1wAwLxF/tnr18+lbjlLzjq0xMCOqaVx/6
         rQkPnCcDwrPrK8U79aIxWAvOanwKsnqT6CwBMBjR5MgG6S3poBctl9gB3ONWK/HtPjUv
         e4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWAuLansOE/ogFDhPM2jhpvqQ5sLlhsgof+9WYv0wJKgDirN2k6tIGc4uCVDzbWlrPRtOEZN2WIcYvMupI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7sKw8rNm3G5ARyXJOVNe8Z6h4VI3DnA0SP2aCpg9SaQtv5et
	iUsEpYb7C0DTMo0B+qzWTT91DlGqSiho1WuowuQaGgt4BJiQZmiip+Jv6VfmeLIWRnontixEUxc
	bxdy8sO3+pcxEACf0lfVAIA4RFoNZi7Yz947GVGlf
X-Gm-Gg: ASbGncuZXKketGbtytBAU5MumJsHpsnXQtvtrG3Q5xf7mGoagd8kxaxPJ7ubpZeNoEJ
	kCYvmZAG9JZdcfhWqpWQ0WiLB5uK1ALn+Q7yZCfmkARaY04RRB+GJnM36D4pgyJ5AK7yHXeBhnV
	FZwSrv1LCYGK9AQkH2bEQqxT83z8JXvWm0W8v/QS7ZbEQcxL2ipgNZTfqEPwWQPYceZIojtaGQW
	Scr1+FgVrTDJTx6qZjuAHznWlkiRf5mGbLb7S4mzt0r2d07fC7zQuspMtZcIGx0vg==
X-Google-Smtp-Source: AGHT+IFR2/iMkStKZ0a8zzBrBpy7PAaXOuE6GtKGvb6nOuL663qM4JQSRroZMOV/Sebi5i5ZULUxa18gYqkX5fMTTAE=
X-Received: by 2002:ac8:5fd3:0:b0:476:f1a6:d8e8 with SMTP id
 d75a77b69052e-4b291b9c1efmr693801cf.11.1755632291072; Tue, 19 Aug 2025
 12:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <43a256bdc70e9a0201f25e60305516aed6b1e97c.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <43a256bdc70e9a0201f25e60305516aed6b1e97c.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:37:57 -0700
X-Gm-Features: Ac12FXzh-xPyuuuSr3t5QlnJu8i5ZGtJ2KSJsIVV1_FY-w1P3-CyOqXsgUqFpw4
Message-ID: <CAHS8izNq8wKXwiZs8SeuYhsknR=wAwWPEnBOxUgcMhCoObQ=xA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/23] eth: bnxt: read the page size from the
 adapter struct
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
> inside struct bnxt. This will allow configuring the page size
> at runtime in subsequent patches.
>
> The MSS size calculation for older chip continues to use the constant.
> I'm intending to support the configuration only on more recent HW,
> looks like on older chips setting this per queue won't work,
> and that's the ultimate goal.
>
> This patch should not change the current behavior as value
> read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

nit: AFAIU BNXT_RX_PAGE_SIZE should be unused after this? You could
delete the definition in bnxt.h if so.

--=20
Thanks,
Mina

