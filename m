Return-Path: <linux-kernel+bounces-862510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE6BF57DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEBE0351537
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959432AAAB;
	Tue, 21 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noEdxz1c"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76C246762
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038765; cv=none; b=VhD0J6AloRh0CVo25GUgmBa1ToULVvDwyMsKsXFPEMmI1/lCAGXzNwn863Dv/QPkTzMEywKdt0G2ZyDmWIVm58LKE37fqnTfTVcZpLENKjZAbXr9hOIwY8C7IEWB5taDJAcTafDtGTKrqa+7qgPx5A3UL+QL45sTQcURQepn9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038765; c=relaxed/simple;
	bh=VFQphnGkoktZvUzEwKwCJ8sXqt24rjb9W6hVqumfQyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfDmpgnGde7vIbdHPK3MtWhNecuGxSpuUAeA820XW1o4H676mtnJGmV7BqgGWnv9JWwWsIJc0TMqFRegJQgRJKd4S9QXnXJ0tRHz+IxiClra8qQ66dXjNs/swZ2XUKnyGtUHgp+9nfd9wIzWNZWOvmbV7sGra7nygDy8jItn5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noEdxz1c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471076f819bso41976895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038762; x=1761643562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=noEdxz1cmxgyCrbf3Wd6MWCQBkpKNuZl7HVtYdP3Y3ADUEPOGo/W4mv8fGrl1kwgzs
         bF2CQSmwtzufVKYln5FMiHBQMBapwLx1+DDrJjaSyhC7Kez+WAI6iP4j2YvQmOllZmU7
         1IvELMEK2Tcic7sajjCEp6mIlkYRnpjSUfJw24joMxXOVfhjeQZu1xiKCOm7cbzzUCLT
         Mq/ls385ZSNy6/l/+Km18SBrMO777cinIWNAwFhtu9Z461iVlI1N6PHW7+JRQHINlgHc
         3lpHy4tO7TTbHoShpmcBV2JXIe3ziQxhzpoWB+kqiDPbyrNEdbu3gLjbXLYHYIQ3FtDO
         O2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038762; x=1761643562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=j7qUS3YkMyHyC1dHAYwK6ehbs8goCH7COqc4OXx1/xkdqhNBZnjgUYmruh/2fCNG8h
         pxO8gJF+1Mfu8uGOsX/ZwWXv3uZX3UsLwfyO2Zz4ydEAb2SMHN8pWtGCWgUvcPET8oHq
         VeHbVJQHfByoEwKHltBuGg/aG97W4qRd3vuWZg4FIKMPNaCe6pfp3hPXEdbG0X1A3rX/
         jKotqK0MSfanFstEbZ4yLZon3yLuTfzF6b7vYdH7oAyBzMbqjxmVjw5y3eE3JhQ6CFtf
         o9q0QKiVYbXdSnWYHePRBTDIQHQBpWEWzC1R966dG+7IRqjQmCshxC5ucLOA3EiBaAtD
         Se6w==
X-Forwarded-Encrypted: i=1; AJvYcCVEGyDkEw4JotS41IzylivE48GXhXwIegHcXT9tLcLFCeI2Vqmw+ea3w2TFXCXcelFYefLPkN8lgBDoL24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAs12ebEi1AnhR8O1iP6gR8yr7cM48TaaEAy0POz7/Q3LfOWJH
	6dzYGEjc1jJBTIWjcpyTCHUSJpSlUptZMEsrVjRszkMsYBkMnbperjyr
X-Gm-Gg: ASbGncstz83crtbtkSUqQVw+28d46Gv0SFa2Mj/YdMPZ3KldCbzm1BtKCJ8vlzX8rJm
	nXOmcncj5OJcetXx1e2BElKtJDrsK9kYZIVkA7wF+Mu2I+NfSFI++DsjJvAodnJZE/K4I9rOIJ5
	u8rf2LlrZrq9SnNmBa+YScNARwaSDvmhl7ohwcSGEBP9/1kL1vhwaos8vvwJaN9Mo0LhKX298th
	QoGi/mX7ncn+KkVwysYz6oqz0Qr6PHLUUTvbryG6QqYG2cjutQqpuntQLrXj8ChtSsJSkAhsw12
	tFRE31YblG7ptKYwiMboMXcv3RbQgicNiJbcMcfNXDKGSBL5djHkN+Uh0a4IosVU0lS988XGVUr
	q+kiL4kCejiLJ89fFwC2Qd4c7rdKlbtIks2UHtSFZyo77pPsBfQ8y0szQ1hsFkBxFSa9edssuaK
	E3ma5i+kMefGbRw5xeTLQsoz3YLdvF34IauLJORQbXEXKLgE1mldoZpiU/WOHr3nk=
X-Google-Smtp-Source: AGHT+IHG9qJps3XQWPNYA4OPAfHFr1juDXQi4VNXIDoZlFbccTY3/HGAyaSBPRBTf6Mk1q4iNuNdsg==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-47117931c89mr109559365e9.41.1761038762110;
        Tue, 21 Oct 2025 02:26:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm19195113f8f.3.2025.10.21.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:26:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:26:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251021102600.2838d216@pumpkin>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 14:26:30 -0700
Kees Cook <kees@kernel.org> wrote:

> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

One on the historic Unix implementations split the 'sa_family'
field into two single byte fields - the second one containing the length.
That might work - although care would be needed not to pass a length
back to userspace.

NetBSD certainly forbid declaring variables of type 'sockaddr storage',
the kernel could only use pointers to it.
These days that might be enforcable by the compiler.

	David

