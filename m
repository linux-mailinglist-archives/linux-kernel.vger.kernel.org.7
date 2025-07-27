Return-Path: <linux-kernel+bounces-747223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D19B13122
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9393F3B117C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56D2A1D1;
	Sun, 27 Jul 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sV/1Vr4i"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BB1A5B8C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753640289; cv=none; b=cuLep37laII7M4DSNtHUktCc6urbgfU4t9zwHuYLLt8rhzaMO6NDvo1RZJDczr9oB6oFLrQa7Y4LIxMJ+guRUD1GYB8QSMl957/QPa2hAsNMlfBxCR3GYnF4hNRizvb+SJWeZS9LTSM+JNa/ONlMyzlHFGQFe86ZAkqJvesQT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753640289; c=relaxed/simple;
	bh=Oh3MgeqnOYp4K9k+9BDHHKlnsg0BQzGc4dHtDzS2t7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQNWFKn1ARnE8oaYxCW9+Jt4VXKvaBry8oGgxBojgXsEA/xZ3EmdZRkieEvr9FJ4O73mAgarAOkls668h8e6Ma4doLbWRidGuH39ZDsLL7uqOMtZ98R8l6pGVCdLV1NZElvD1MbO6nxMMN80Mq+NjzcmaUE5Wx/s+XXnsExgt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sV/1Vr4i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23dd9ae5aacso155595ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753640286; x=1754245086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrCK6S0JfTZW8/CSdvpX6rnp+yviEEZjXuCZqY3YBDU=;
        b=sV/1Vr4iJplUzZMvP2yLPXc1rMOvJt72RobXQwj8qSYflVTUJU5fTyVT/4ri0PlcrJ
         LRP/pyxBiowTLebJjW85wu1+T9RnLHPNIFyaFGIXHgbB3llrvJltINiaoqIIdCXS4BLR
         Yj3HIOAQ18/XEVqwZS9+n1xWZyqaG3Y3EbokJfWnnmZf98Zk0b1g2srTGkmSCkc2ScHb
         kC5QrYsuRV72KkIEIUXQ8GZcYSWnCGELHgGIP9lawwi5EfaqTbJfpRlQ/UgBZvXz6QN+
         UtJBEy857nKezVfIPMktI/8kZraBAACVsR//kYz7zSGJQ0DXPnzTcqox7JTxf+vBKSyg
         ODHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753640286; x=1754245086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrCK6S0JfTZW8/CSdvpX6rnp+yviEEZjXuCZqY3YBDU=;
        b=vXo6LkarFyplw5jHoEww6hieHVOqwo4aP+ra9vpNOYuASEvxU6/ZLUUbe+oXc/UEIf
         DTMjwHxOYgi/HSx99stSHOY+C2UsiiYRU4RdRqjwPEgGS4d1goLpE1BZ2oetkZJXXeq3
         gCHVAIhENOh5zCB3bGkfvB4O0gxInpaWFs1btMigD3ORRKj8sDg9YHKiPpzdC/aCrDZ8
         ocBbHiQMtoUNjILTdnMgeh0C4ALkqA5FDd11UifbPZi4nILo/0ftBQ2fTGplf+B0F3I4
         WevmpUQyJLJbvOFrcyHEI9u0KY2V/RGL1bfJIcgTAEVHaN+IcqQAikaEmXim7PsiL7Jh
         yg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8Qd6AlOt1DdUuZxUtsAu9X5W+5okhMTmUYiL+LINpp4NGeyF/AGcWYBzza+SqBZUVPidZhWPm4AgpO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNr3UdYjo0nAye7aJohltdgERw8fkbfXNDUCmHbwf3qBqIbb2
	79dtEY2pveV0qdpSuF61aPj77Tlh9KqWI8Dvb1WpvpXVbhL0PqdsavCOfFE9mNhe7A==
X-Gm-Gg: ASbGncvlRD7RT/WuUhMnLHJHMTW0kU+nqd2ODvk70e3itH74eUN3OkIXp3tfq3sgAW+
	LH8oal/FdbhevE3JqFLYvO6IFlUDhKy90baP4bfP1u0JVX3RbPkDAFiAjq9a+SD93WGSHLwIJUl
	9HQHw5NKGoFUe2UwZp/VtdMtNg4CT5e6QpxwDZDdWiDS+AuUA+gAd4bkuI3OIGebuD9RPLtYKPd
	w30CAHeZf48/TBJ0t5KQMoVamamMJvBSUNK375HHSHUfIWW0v1Nz2wTByxMFhvuH2LMtIM2CdSh
	Wmwnpo/qplQZnax/3I3G4fZZG96K3OpQ4EF/4Z5kXHE1A7E8S9psKz38eke66uKLz5ULfbISh91
	rX+qyWcvJnlK5AzOg/nQSHUPrg4Yj/i8xSR8FahBW/s0mI/Ql/oNOl5g65yAdkVY=
X-Google-Smtp-Source: AGHT+IFuHg9slp36BYzs++FA75XcSgyone2OHe/zLOFgSAqf2O6bVxYmK0j6OseG6HWIpZ8I/hYfBA==
X-Received: by 2002:a17:902:fc87:b0:234:8eeb:d81a with SMTP id d9443c01a7336-23fbfd1952amr2788425ad.16.1753640285487;
        Sun, 27 Jul 2025 11:18:05 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02640sm3851608b3a.37.2025.07.27.11.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 11:18:04 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:18:00 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>,
	Shai Barack <shayba@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v19 3/5] binder: introduce transaction reports via netlink
Message-ID: <aIZtWGPFCsHdNvq1@google.com>
References: <20250725183811.409580-1-cmllamas@google.com>
 <20250725183811.409580-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725183811.409580-4-cmllamas@google.com>

On Fri, Jul 25, 2025 at 06:37:46PM +0000, Carlos Llamas wrote:
> From: Li Li <dualli@google.com>
> 
> Introduce a generic netlink multicast event to report binder transaction
> failures to userspace. This allows subscribers to monitor these events
> and take appropriate actions, such as stopping a misbehaving application
> that is spamming a service with huge amount of transactions.
> 
> The multicast event contains full details of the failed transactions,
> including the sender/target PIDs, payload size and specific error code.
> This interface is defined using a YAML spec, from which the UAPI and
> kernel headers and source are auto-generated.
> 
> Signed-off-by: Li Li <dualli@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  Documentation/netlink/specs/binder.yaml     | 96 +++++++++++++++++++++
>  MAINTAINERS                                 |  1 +
>  drivers/android/Kconfig                     |  1 +
>  drivers/android/Makefile                    |  2 +-
>  drivers/android/binder.c                    | 85 +++++++++++++++++-
>  drivers/android/binder_netlink.c            | 32 +++++++
>  drivers/android/binder_netlink.h            | 21 +++++
>  include/uapi/linux/android/binder_netlink.h | 37 ++++++++
>  8 files changed, 270 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/netlink/specs/binder.yaml
>  create mode 100644 drivers/android/binder_netlink.c
>  create mode 100644 drivers/android/binder_netlink.h
>  create mode 100644 include/uapi/linux/android/binder_netlink.h
> 
> diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
> new file mode 100644
> index 000000000000..a2e54aa42448
> --- /dev/null
> +++ b/Documentation/netlink/specs/binder.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +# Copyright 2025 Google LLC
> +#
> +---
> +name: binder
> +protocol: genetlink
> +uapi-header: linux/android/binder_netlink.h
> +doc: Binder interface over generic netlink
> +
> +attribute-sets:
> +  -
> +    name: report
> +    doc: |
> +      Attributes included within a transaction failure report. The elements
> +      correspond directly with the specific transaction that failed, along
> +      with the error returned to the sender e.g. BR_DEAD_REPLY.
> +
> +    attributes:
> +      -
> +        name: error
> +        type: u32
> +        doc: The enum binder_driver_return_protocol returned to the sender.
> +      -
> +        name: context
> +        type: string
> +        doc: The binder context where the transaction occurred.
> +      -
> +        name: from_pid
> +        type: u32
> +        doc: The PID of the sender process.
> +      -
> +        name: from_tid
> +        type: u32
> +        doc: The TID of the sender thread.
> +      -
> +        name: to_pid
> +        type: u32
> +        doc: |
> +          The PID of the recipient process. This attribute may not be present
> +          if the target could not be determined.
> +      -
> +        name: to_tid
> +        type: u32
> +        doc: |
> +          The TID of the recipient thread. This attribute may not be present
> +          if the target could not be determined.
> +      -
> +        name: is_reply
> +        type: flag
> +        doc: When present, indicates the failed transaction is a reply.
> +      -
> +        name: flags
> +        type: u32
> +        doc: The bitmask of enum transaction_flags from the transaction.
> +      -
> +        name: code
> +        type: u32
> +        doc: The application-defined code from the transaction.
> +      -
> +        name: data_size
> +        type: u32
> +        doc: The transaction payload size in bytes.
> +
> +operations:
> +  list:
> +    -
> +      name: report
> +      doc: |
> +        A multicast event sent to userspace subscribers to notify them about
> +        binder transaction failures. The generated report provides the full
> +        details of the specific transaction that failed. The intention is for
> +        programs to monitor these events and react to the failures as needed.
> +
> +      attribute-set: report
> +      mcgrp: report
> +      event:
> +        attributes:
> +          - error
> +          - context
> +          - from_pid
> +          - from_tid
> +          - to_pid
> +          - to_tid
> +          - is_reply
> +          - flags
> +          - code
> +          - data_size
> +
> +kernel-family:
> +  headers: ["binder_internal.h"]

Hmm, it seems this header inclusion was left in from patchset v13, where
the 'struct binder_context' needed to be exposed. Not anymore though, so
I'll send out a new version that drops this part.


