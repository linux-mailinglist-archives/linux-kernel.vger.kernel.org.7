Return-Path: <linux-kernel+bounces-774625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A9B2B52F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A859B19620FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922726F280;
	Tue, 19 Aug 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ptk8UqZQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10C1B85FD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561630; cv=none; b=JKR59y8XjUrCPEvI5B9sePC1ZeL0gKy/Ixj4Tw4gatAxkB/yxjSPpV+da94Jz9MdmRVCzLMc5/LbdUWTXeZSLzEuoRqbYp2KnMPkivnLdseKxJ9XRLQxT6pf+Ex0TFowSgSYmyIumyBZpwQxS+s0x21ILu4Yl2/emYyQ5bjUXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561630; c=relaxed/simple;
	bh=eVGtw0RifMH4dB6Opi7sPhmBoc91u4F4OTi82OGM6p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLh+sv9xtzlxOvlTmWOY+YpxWhh5/2e06iZ8T/tQfv+ibmD0j6TjyIyR6w/wFd/Gp+2+P0ZObvzo3MWYRyp41XOtQPpK6YrShYp4imSY29ZpOR5+2Lz2tOb0Csw4Fpnb8r9zvXXcKAJqPx8l/j2bZCkVvfGXjfCbZ2R6wtCxhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ptk8UqZQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55df3796649so4248e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561627; x=1756166427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVGtw0RifMH4dB6Opi7sPhmBoc91u4F4OTi82OGM6p4=;
        b=Ptk8UqZQFh7GWEjH3RZOwJddEK0mC5FrBAa6v5snwrpGjprloVaf0kJNgNLO/RrdNB
         OeY7mKaLFgLo6io7HK7BY3CAwoQstG6gLXUXRzm5Z+4O4L3UH1rekgDqkgKTI+u5kfuH
         mfNlSBUpjxvQInHfzjEe8UN7r6JjyCH5W+h/1TvX6GTRjbVhajYtS9GWfOwksyf8R9jv
         Ps+3IgKbzK9vafogJo8zEtARe5lFMJUwZRZDS69oh7tKPMhRHLHQNpvnOlVRqtIR3X8o
         Y+5G7SdJ+TrWi/9t6NjlpuR3pto9JXGcfFhUIDuJRG2GNxN5lpEkmaRfOSnnrXOBucx8
         yIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561627; x=1756166427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVGtw0RifMH4dB6Opi7sPhmBoc91u4F4OTi82OGM6p4=;
        b=CdPyXGq6+uagzqihvRv94zqvy2REwDsmhaKAKGMhPZ3mUQut7nHhqs3PWIWwDQE4WZ
         RCAVihfcSrvj1AXu284t5T6weogzNy3SOTlnJKTvC3BxtfBS5XgMos2NeBffkLmHvrCN
         k3U1WG4t+3SJgxWUlh4LWR8LGUFqrsFUsGO83bE4Z1+5F5lQHcH+ljqqOCj0UmUsw3OY
         a7s55N6hMJPPPoeLO+nUnLQD2fvORDDBA1NAfkbphfogAqxIAqSuMrehEnDm2RGIhhl3
         zv+secP0M8fSgImlGM/F9aZ7gzHdhDfYOXw8Pz1cjIlkbqWpJBBoSM8nSzONizGgIcZa
         ppKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytcLG9kFPwZEIjOy2DHQ0K/aFjb+JiUNxXGdsdhiEqtCYAbIaEwK+yjGcAmVtpwii+TN3JGUhbnrHjYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYfAnXBByvLoQYLDWovPWdjsaIVEM0mkE47cKz8kFSKW8b3zL
	uYu+gZVAOod7cfSZatzrW4NcZy5s1N4Lc/aMBdn/ZpzmryFPZBq7udnUGegj31GCWy38ZYzIaEI
	Z72jiYSzeHaVYVfPTww5863LGhjRCDRXUKwyH9pWe
X-Gm-Gg: ASbGncsnEgkPLRgl9fyXv9zrbvzztXwCKN2klMfwhuO4sAE+h+nFLwPYvaCj1jmk9Nz
	Vk3xiex8xiPqVou4XUb9bZScn8qWukbUhQQ84k5DUv9j407Ta7jpCm+6dsV+aWLzocU/XVlaHLn
	KQT0YNT+etqc1/hGAH9L2g/rF1ksY3jkR5wPt7fhj4qOmTPbl+J7bZ7sCiPYVWwAKtFRMJc7z2n
	DUzFxABEgUcsl3qajkoXM55yCAPnO+PmOJR3pTfNRvj
X-Google-Smtp-Source: AGHT+IEZEaETdAR6zcqYMOSJMAOQypdk9OIqzaXxKsBGtn0E30zwjU1WLFWapWhBelD0iYBZ0U99b4mUlXJ5fCSa36o=
X-Received: by 2002:a05:6512:1092:b0:55b:749a:35b6 with SMTP id
 2adb3069b0e04-55e00c43a89mr47660e87.5.1755561626616; Mon, 18 Aug 2025
 17:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <d25ecf7a633d5ec6d86e667ef3f86a13ea1a242b.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <d25ecf7a633d5ec6d86e667ef3f86a13ea1a242b.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 17:00:14 -0700
X-Gm-Features: Ac12FXwnRiB0WNJpRl44QeJvz_0GJSGinfE7h26oEfh-sETdFXD8uKnYn5wG09w
Message-ID: <CAHS8izPyDDxtDM4KcnuHzr0BJ3WYd1mv8gJEjG3zAW=Va4yG0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/23] net: ethtool: report max value for rx-buf-len
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
> Unlike most of our APIs the rx-buf-len param does not have an associated
> max value. In theory user could set this value pretty high, but in
> practice most NICs have limits due to the width of the length fields
> in the descriptors.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

The other driver that supports rx_buf_len I think is hns3, and I think
you can set the max_rx_buf_len as RX_BUF_LEN_4K there? It only support
2K and 4K.

Other than that, looks good to me,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

