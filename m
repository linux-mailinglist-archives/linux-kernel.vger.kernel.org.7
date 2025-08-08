Return-Path: <linux-kernel+bounces-760195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4205B1E7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D2418886C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D151274FDA;
	Fri,  8 Aug 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ1bHPb6"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B054273D9B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653637; cv=none; b=CVETlolRD4kD++8L7A5r6Z8R/bzNH/nxCk7e7mdHZytDlp1LDmGCx8OmlGglNSxEB9APhSKRPRNFnUbZN7+kBXFoRMQKpDZPPe0+/gUGDJftarpIXpsYPhoaeg7z12Qc9zxj4KOI0sPPo5rjzzWAEPB7YpSD9cM7jrqDhx67Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653637; c=relaxed/simple;
	bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUMPcI2X9h9WloPk1B/nLPjFLPbWEBU3Lq3NNuEvcsUTgUkpjECTwB9/6Dn2E+LYpbwH9OQy1NEGAd4q6E1kuU4uWU6MK5sITVS1v4Up0xzIkniktm7wyh4aIanYGAwObjg+4P3FnDSZVEnj7FrjpPooyXHWDxJc9UavgCThbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ1bHPb6; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0619a353dso14707831cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754653635; x=1755258435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
        b=UJ1bHPb6UzL9EriM7f3kInw0RqOOVTi4Y3qSx/mDqD03MFkcv6NTXrF45U39VGPlNb
         mJp0JuFSYq2fYXNU7fZsWNgWasu1tuokZH8QQYgxX1lWsOZHIrxoNEUSNLHRLhPx5tEZ
         LVcMezNcrYZCgZFItxw9YdE2d5V3e82C1EVBLSR0MzoFvGsbBdlcjTYBaIa8oQ2m4Zo7
         0rST969nCOR6Ik3Ikc/uijvnxIn9lPQPFBww1lqSJ9wwjV6ttcrAJh43MmDIXx9Q1lW4
         j0Io/yMvJ1ArvEIsCgYxXVQkTGfA4gruVoSAiTLfWDt6pYkO8p4V9wGZ7KqOFdcujEUc
         +rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653635; x=1755258435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcuWKhhUvZvPNQENtkOdZpOgeoywYXt6MaaN4JTcyCQ=;
        b=HgRpDMZX493i8T9FNCzesBcYLIw+LZuTTE5kGa/5oicBSnrUHtn9wPIWqe0t9/Mbnx
         Y7BfK+lxRM6J6XCIcZCtT9RlcKkd08eoeCJNMf9/UPEf7RspEjeq4lJrZVgT5guxV5nd
         zGlZ8Pj+ZU/495F5dFDV3d0HzFB5m4E13h9duEFW7GOjjU5KGYuQL3WORFRo2+ixv62D
         DtFfI9Z9sl2B7Cv7TO81z1wLpy5TvuxjybCh5hSmB7GHdwcVsnklb/81HvRPVMNF5Wt4
         cRtHAPjx21mW9G+mZsT5aHN/t5fH52PL6Okq96hOG+3KkvPGiLw00GNkSDW5/ca4VXHf
         /cfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1ELSesQNSoi8ivyv8wc7/hracbOPwj6Hp8mjMKkZa/Ctz0wZnKd6cB2sC6FpgRF5Qp7Eg5BGb4Q5ZZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iUQLxoCqN/yge51cJemoRUKCbVoTo/PgGAcw6wPDeVzJPRT9
	O2Xxsm4WEU9BJAh053Y0WYJIbpt7Fje9e8N1lfbIW5/hOx9vmwKYbI2S5TX7E9irLzjq08S86x/
	RPfZD3/jtwo+CKp3Mzgi2nZUpggPam8nn7nZImhYGJfuJDASm7/m3u5jA
X-Gm-Gg: ASbGncuYXnvaizPxdaz/TjMHVo2PXsi3O7+TOAacovduw+oWZCJf2+gaXZI5Srv/b2I
	lhC9asMfehqzspoGrbvibkhLISHhdqIUi6vu6VgsG9YVC8kZ2dwNY8MFW/U/pFSGjKE3CgixHka
	V77YYAZYuXDxgGKOfPh773WJQ70RwoxHq4W/owQVhDpAw0GVBv23GDwTlDQIqnPe6qhrn2q5YsV
	BU6fKB7ne7R3rA=
X-Google-Smtp-Source: AGHT+IGr8F1RGtQSW2Vtwz/Msi7bNt9IV8AE+f7GDLRdZpYIcYHn2aNXfJBHn9HR8+ZFzcOq4gB+P5UPdJ6DwCKZeJM=
X-Received: by 2002:a05:622a:4107:b0:4a8:1841:42ff with SMTP id
 d75a77b69052e-4b0aed0ba6dmr30476541cf.8.1754653634882; Fri, 08 Aug 2025
 04:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
In-Reply-To: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 04:47:03 -0700
X-Gm-Features: Ac12FXwpok3ZpqBt50Y3zhETSQWUuwnkl-hL9VfDV_Of0cOBpb5spcB-yqutsTY
Message-ID: <CANn89iKEXJHxrpCLT=DNJ6W3pXO0L7s193b-a-+uWjRHeAGQpQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] ref_tracker: use %p instead of %px in debugfs
 dentry name
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:45=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
>
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debug=
fs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

