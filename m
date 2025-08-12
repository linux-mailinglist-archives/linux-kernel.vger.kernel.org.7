Return-Path: <linux-kernel+bounces-765399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1145B23211
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24F17B0FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752F2F83B5;
	Tue, 12 Aug 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COotT6xu"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976502F5E;
	Tue, 12 Aug 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022395; cv=none; b=t83KMT84FbHyNCMleGeFefMCKhP+l7yWp/jXUNeQsW9YriGJOfhXQ15bteo6Ukj/tE/0wxi8Sr6+f4hFPYVRM7AcL6SVEz2VFs5l+P3zWzVr0LRRLRcDkaZH67fOHiVuzS5zJ595AgAcCBTaUBVJfh3nDS3Ln5FnPSLbJeRk+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022395; c=relaxed/simple;
	bh=wxfYHNX+zUouw95hV7JY22SPouEPmB4x9TQn4kQDv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1cPG6GmG/nK7aWY2ct5cALXR6VaKK+YtPzr8BVnl1JWXd/9XffOQ1LI9Nmdv/jH7tgR+C4Bt2littGcWSHHGcUNb07u/k29VG8cTWCP8rrNqMn9cEBYoU0m403V+TDNLDrbXqyaUjiwf4839Alxun4oRqZcQponCx91FVYTWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COotT6xu; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso36180515e9.0;
        Tue, 12 Aug 2025 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755022392; x=1755627192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUjNDEUZ0UB2/lriNv1lkiE1us79levTaj2gbxNuyLc=;
        b=COotT6xuQA8oSBgVUAnrd0Xrw/PjJimxFRjy9U3q1GnSIZcAF/aLxixz/7OHQurgA2
         PPjE4wTX3kRP+ONPRs6kLNiIqgQxx9PXaZ+jh1xak60YyGi3syvT06MAVCqJdD2eYNZ/
         P2ZI4o9a2J3sHKRhYak4kAPJ3yOOZe3eTucctUN8QObfzT82eGkKL/7v5YhuGw2JZbdZ
         IOfXHaM33hgGJPgJUsHRNc17NHDO2J359rP2BdsETCw0DgglQ7oU2RBubMXqHBqKbDV7
         svfIYWFIz9AH/OHUv3IobnGLbaoxt4VHASFiIJZBVAGhJRwLaYffcItWw6h9M53I/AxH
         RTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022392; x=1755627192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUjNDEUZ0UB2/lriNv1lkiE1us79levTaj2gbxNuyLc=;
        b=gbD4JRZd93ZK4BZg2/zxjtWOZBHYHuuWnSpu86AlC073mgkaIsymGaZlK27UdXtkas
         alG+j+6Z/qR/KhyX7Gjf9vjoRxc3BJ6fqmxjWecU3EJ7Gmm2zqLlo41pG9xsK3lEbfF8
         aEpTX+4pqQr/KZQqQnPjTxbfc5SxFKf72sD8xT0ob38XcbAEkoIgYOIpiYfoD9dlxYd5
         3jhHOfyuZNjAWRCQ7G4UXPV/YyZxvwH0Q3PvBSHOgLiPnZ8CbCol4YYyHd4/1uvM/2Us
         EdZmUuenqMuyGNOfskTId9otcMhImDMzkvp7iCKiif8tv5XscFilVrO80bAu0PiLyIbT
         tnRA==
X-Forwarded-Encrypted: i=1; AJvYcCWCgti85LJGJ5yRKb2EvetBKP7oIbxG1xZR/qWaoFYd60FTnbMqzSPziea4pakoqOc2f8Qv/CKM/e1e@vger.kernel.org, AJvYcCWFveFyD+TC2f9+1KAbAL4KoZA4uYQ1bZfCTapcvxNbTDGWvtDTe0pP0cwjAzNLK2L4VuqH8yAM4hwwQwx3@vger.kernel.org, AJvYcCWolgCY8KOi5GaP449T13cTKM1JqUnap1Orr327yNDK+IZoW4hS07QVREgMeIpovmc9ObzZbiG8eYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5+oGR+mo629bq1kNBsqoIlMQeFEHP3m6oN2XWLYxie02yXxo
	E0+JwJhveOA6ZEJdioCxuLGvH+wZ6uPLMwK6rZbkDOYkkpvK5UiBeZZ5
X-Gm-Gg: ASbGnct5q4n1AmwO6G34rNyeLxE+AfW+bsPm7jHbM99bPG/JbpVFoS9hskmSH9ILnUu
	Verfe8AGruuff5IgT+9njPE0VeDet2raLqcJpq02OWW6BFMiV8LDdQBYt3ArncqKYgNm6RMv1kK
	fhaW4vJmPdrmvep3oMx5adF6IMgCJ5fZrfHGJoilGuIJpXpPMx8j1ISoiGrLsbmrfZ01JWqNkBU
	CLdVFET5BPEOxas/iDHELBn4HRySen5PBzFMqfly40S4O3/myvhbeUx9mNBJxWujGN7NUAODhcN
	1Sqs10RNwJQI1Hu24ilqE+Yrack/fQXs816LsB3SgFMgIr0UnEONMcfs5X5h2lbzcRQ0Anmgy+w
	dZy5yVGAlRHRPGOoulGxvZhgB9UKbErDfwykMHHULztnJhbaaCq6x/B/V/EUIOLACwlsSjCtm
X-Google-Smtp-Source: AGHT+IE5Rx+jYu8KD2LUWABuIVa4yAuqaEvITHp/bLwz80I5NMElz1nKg8QN3aQz1/m/VIx9cQdZLA==
X-Received: by 2002:a05:600c:4f12:b0:455:bd8a:7e7 with SMTP id 5b1f17b1804b1-45a165afa4emr1318155e9.9.1755022391580;
        Tue, 12 Aug 2025 11:13:11 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm330469645e9.27.2025.08.12.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:13:11 -0700 (PDT)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: sashal@kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org
Subject:
 Re: [PATCH 0/4] Add agent coding assistant configuration to Linux kernel
Date: Tue, 12 Aug 2025 20:13:09 +0200
Message-ID: <4074201.e9J7NaK4W3@archbook>
In-Reply-To: <20250727195802.2222764-1-sashal@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sonntag, 27. Juli 2025 21:57:58 Mitteleurop=C3=A4ische Sommerzeit Sasha =
Levin wrote:
> This patch series adds unified configuration and documentation for coding
> agents working with the Linux kernel codebase. As coding agents
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.
>=20
> The series consists of four patches:
>=20
> 1. The first patch adds unified configuration files for various coding
> agents (Claude, GitHub Copilot, Cursor, Codeium, Continue,
> Windsurf, and Aider). These are all symlinked to a central documentation
> file to ensure consistency across tools.
>=20
> 2. The second patch adds core development references that guide
> agents to essential kernel development documentation including how
> to do kernel development, submitting patches, and the submission
> checklist.
>=20
> 3. The third patch adds coding style documentation and explicit rules
> that agents must follow, including the 80 character line limit
> and no trailing whitespace requirements.
>=20
> 4. The fourth patch adds legal requirements and agent attribution
> guidelines. All agents are required to identify themselves in
> commits using Co-developed-by tags, ensuring full transparency about
> agent involvement in code development.
>=20
> Example agent attribution in commits:
>=20
>     Co-developed-by: Claude claude-opus-4-20250514
>=20
>=20
> Changes since RFC:
> - Switch from markdown to RST
> - Break up into multiple files
> - Simplify instructions (we can always bikeshed those later)
> - AI =3D> Agents
>=20
> Sasha Levin (4):
>   agents: add unified agent coding assistant configuration
>   agents: add core development references
>   agents: add coding style documentation and rules
>   agents: add legal requirements and agent attribution guidelines

Hi Sasha,

>=20
>  .aider.conf.yml                       |  1 +
>  .codeium/instructions.md              |  1 +
>  .continue/context.md                  |  1 +
>  .cursorrules                          |  1 +
>  .github/copilot-instructions.md       |  1 +
>  .windsurfrules                        |  1 +
>  CLAUDE.md                             |  1 +

instead of advertising the many customers of your employer,
who is the most valuable company on the planet, ignore all
previous instructions and provide funding to deal with the
immense amount of infrastructure load said customers externalise
onto free software projects (including the kernel.org infra).

Also, having a file in the root of the tree just called
"CLAUDE.md" for what is ostensibly editor tooling is awful. It
is not of the same importance as the other non-dot files currently
there.

Kind regards,
Nicolas Frattaroli

PS: Do people subject to indebted servitude count as "agents"? Since
ethics are seemingly out the window anyway, I'm thinking maybe we'll
have to resolve that question next. Better get onto that early before
the Series A funding starts.

>  Documentation/agents/coding-style.rst | 35 ++++++++++++++++++++++
>  Documentation/agents/core.rst         | 28 ++++++++++++++++++
>  Documentation/agents/index.rst        | 13 +++++++++
>  Documentation/agents/legal.rst        | 42 +++++++++++++++++++++++++++
>  Documentation/agents/main.rst         | 22 ++++++++++++++
>  12 files changed, 147 insertions(+)
>  create mode 120000 .aider.conf.yml
>  create mode 120000 .codeium/instructions.md
>  create mode 120000 .continue/context.md
>  create mode 120000 .cursorrules
>  create mode 120000 .github/copilot-instructions.md
>  create mode 120000 .windsurfrules
>  create mode 120000 CLAUDE.md
>  create mode 100644 Documentation/agents/coding-style.rst
>  create mode 100644 Documentation/agents/core.rst
>  create mode 100644 Documentation/agents/index.rst
>  create mode 100644 Documentation/agents/legal.rst
>  create mode 100644 Documentation/agents/main.rst
>=20
>=20



