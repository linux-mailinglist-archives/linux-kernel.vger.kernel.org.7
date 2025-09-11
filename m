Return-Path: <linux-kernel+bounces-811914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969BB53007
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C863188420F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830053164D1;
	Thu, 11 Sep 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY5usAHu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51431355A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589655; cv=none; b=V4GM6EsYkG9V0ZoYqoJIFngKBwTxvcbr3VRRgNnGn/Bf5tE73dSNrET1AALRa8tI+EFwf+fW0Lgud8pAMfbzllbESnHychY5qANhidrE1BeNCsa5qHGDV2gE7i6qtluYY5DxKs3PAdlHnLIY6CAl8eb+8DsLHc6+WgAOqkti34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589655; c=relaxed/simple;
	bh=H8yk+xrqMoi1BmiRtNvzwsuYwehWP27jlscfOOwW9g0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CcS8qDitGRKpZKsZA7tD7MuHw0ptRjLIH+3ZgQwvQh3b3l6vJX3vx5jiDi8rF1K+yzvlYMM4HZc+QfCV7sjVYMgub1lGzKMFmaeP8S0E/KU8bZHq7c21yBVos27vsXnOKorfKlqQocn2SHx8Lig3aQKItZEPYl3sTzHep8CgqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY5usAHu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so7572955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757589652; x=1758194452; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2HQS+cQinE0HErUF+RK2/CMrXAUaYTUSDi0hoQyZeM=;
        b=BY5usAHuL0pcxURLrYzKIpLS9bohcNiHdFZGsM/RAQJaGFnRX2PgBX/kQRB5VeygMT
         2/EKGTXw6usiTZnn8ISx8WWdmHJDCXZKnia4D9r+l8uVdSqH0AgtQ3wgFBbpB0zBUCND
         j1D5sUOWavyIDoYKtWUEPeXT8BHs9A0UjnH1XSdlouQxV1JM6+b4BRjv+4XGWE2RWf6h
         Yn7DyUgbZe7ypeUI3lna7zBODaeZW5gBi6qr+YoJ+n5vPnBGNS0M28PHzzTVRjC+CbHg
         pm2S/cL/3LmOy+4tSpPiGtzCEWgZacwHeEJt+kzooMj6SV4eWbQokBeVI0ZIrHFSUYfs
         hgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589652; x=1758194452;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2HQS+cQinE0HErUF+RK2/CMrXAUaYTUSDi0hoQyZeM=;
        b=cP4H/F0gxn9jb955KjfSajS2tPvOVKaU0ksrxQscFBWwfdtlTcuGCWlJOie0+TQkZe
         E4K3iMFq0fVKhkZ+XdSRJXmw8knqQ2bcRsduYU7tqysm5CzodbS7vSbgqXJazAapVpy9
         s99cgbdo0KCkpMimDIgI0wKIthY4fzVSDyvwQqRfBFYVEHU75Y+loUIr7i2qfOq2Le6f
         D1fM6EpOJnE+MSPRSjAYQBRYDdH6ZtDZJidabRxHKaQVNkbSO48145Ctup91sqVJ6PWU
         d0nwTq+Ttbnui4aWPjO1QlcBsC3793pBztVNghKkbicuxe9Te5mKmW4pJGSOTq8UsUGp
         nCjA==
X-Forwarded-Encrypted: i=1; AJvYcCXUdvBABn1B1Onuzk37bj11Wxx7+yCRc8/JwYntKqWgXD/S3btT61eXZE/lY/wu+NLNYq9gWfq2y1RC8lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCNmC7C2MA4D+PCEHq3QQp4pamScEYUflps/birkAF1ugYzwm
	+wHMecOL/HmmPpWuWdnQe8tPcURTrBBfPPyxGUVCPKR7jFI9LWdG/Us6gRf/Hg==
X-Gm-Gg: ASbGncth9jXpeFop1pCitjpy6ykUepIqKNGoJDptoSJn+GidGekwTyY7KCY1l64540m
	8RtJy6xHINv4zHgpTZ9bMTWg87G/QRSdZhtwC6RDhh/kmRA4Pw/RHQ/Qyn2/lk+PBM9CTnMyJij
	4x3xOSPxG9M15uL8A4z6yypd0KXvUHv8NHj6Np1nFbGPm2cLGEcUR9VzofjrIFqzJgFvRSldnmC
	9THOkqGAgvZ63DAY5yB2LL9sUvf3QIkQ+/QiQahw1N1LxjoeQfDjGwPgOwlDFZHJXvnJyKkkGxs
	B03bDH0tCYvAY7rKNjvHgA9YRlv6V6QAYQlTL7mfgyL0Gc7guiBjlT4hs2OnrUrtA0FIYMZPZik
	+pKe47uxxWAfpAtHE9ByDXdpwJTamlefk2R/7Rqg=
X-Google-Smtp-Source: AGHT+IGo+F4NUZA5jrtFJZ3gols7D7bXthNGq85BXY2ZGDeIz6G8pf+puXsiQ9wTfeZ6/fjO6sDA+Q==
X-Received: by 2002:a5d:64e7:0:b0:3da:e7d7:f1ec with SMTP id ffacd0b85a97d-3e646257889mr15832414f8f.32.1757589651961;
        Thu, 11 Sep 2025 04:20:51 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm2152003f8f.16.2025.09.11.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:20:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: rst: display attribute-set doc
In-Reply-To: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
Date: Thu, 11 Sep 2025 11:44:55 +0100
Message-ID: <m2v7lpuv2w.fsf@gmail.com>
References: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> Some attribute-set have a documentation (doc:), but it was not displayed
> in the RST / HTML version. Such field can be found in ethtool, netdev,
> tcp_metrics and team YAML files.
>
> Only the 'name' and 'attributes' fields from an 'attribute-set' section
> were parsed. Now the content of the 'doc' field, if available, is added
> as a new paragraph before listing each attribute. This is similar to
> what is done when parsing the 'operations'.

This fix looks good, but exposes the same issue with the team
attribute-set in team.yaml.

The following patch is sufficient to generate output that sphinx doesn't
mangle:

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index cf02d47d12a4..fae40835386c 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -25,7 +25,7 @@ definitions:
 attribute-sets:
   -
     name: team
-    doc:
+    doc: |
       The team nested layout of get/set msg looks like
           [TEAM_ATTR_LIST_OPTION]
               [TEAM_ATTR_ITEM_OPTION]

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note: this patch can be applied without conflicts on top of net-next and
> docs-next. To be honest, it is not clear to me who is responsible for
> applying it :)
> ---
>  tools/net/ynl/pyynl/lib/doc_generator.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
> index 403abf1a2edaac6936d0e9db0623cd3e07aaad8e..3a16b8eb01ca0cf61a5983d3bd6a866e04c75844 100644
> --- a/tools/net/ynl/pyynl/lib/doc_generator.py
> +++ b/tools/net/ynl/pyynl/lib/doc_generator.py
> @@ -289,6 +289,10 @@ class YnlDocGenerator:
>          for entry in entries:
>              lines.append(self.fmt.rst_section(namespace, 'attribute-set',
>                                                entry["name"]))
> +
> +            if "doc" in entry:
> +                lines.append(self.fmt.rst_paragraph(entry["doc"], 0) + "\n")
> +
>              for attr in entry["attributes"]:
>                  if LINE_STR in attr:
>                      lines.append(self.fmt.rst_lineno(attr[LINE_STR]))
>
> ---
> base-commit: deb105f49879dd50d595f7f55207d6e74dec34e6
> change-id: 20250910-net-next-ynl-attr-doc-rst-b61532634245
>
> Best regards,

