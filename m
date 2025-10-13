Return-Path: <linux-kernel+bounces-849937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5290BD162C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC913BF6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF642BEC55;
	Mon, 13 Oct 2025 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6nsm/dH"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2452BE7BE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330299; cv=none; b=jPT+mkB+QZPcsiTtzDREZ4EkFs3o1j2wEkCzcta0V8EI09/MlER4D9Y1nDBRn5JI6gJVXiJYtXH8Ip0SYsZrJwSCxLF6twFCAOATrbcbhkWkhQ6Oc4qE1dD8+XxX976vqHU5ZbV5sX6LTxlAAYRcNet94JxQP1p0bcgD7/hkSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330299; c=relaxed/simple;
	bh=u8oK9s5aByPzbWDSJU0MuNHc93b7ngPnC+4lAT7yplE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbIaS5jBx7K95mLp0yMYz6h35IL8QpWTCesuaG2oL1pW/yeE/nBLZIHbpw1hrRaPnGSaA+dsVDUojMnfbfszStgWYHY9dalW8H62SCe9kVga3KOSEz12hNVzTY9CgXQh+JmXiUzF+0ohvlbsSXQJU3iEAbk8gnXpzaVokJGLf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6nsm/dH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32f3fa6412dso535830a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760330297; x=1760935097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jQ7mGdL6AjL3n52++SuIetPTh8rjsnTvNAsGSM8T6g=;
        b=G6nsm/dHRc3RliYiPUISlXZw/eRg+0suGV7k3dLPkSwZ2NjxmjxvWq3fnWHieXY8ah
         ZrQjSraFE8Qw/pLX4ccGEjBD4oYXBMusISYjB3CwAPBpuLcnTj+MHHQUU46DCoy5KGE/
         EGx37dN9FqPoB4/gLoB2+CXjng6gI3Z+AoRMyWdCjHkwVojrH0Y7syea7JHYIWDxxUzX
         yEEW4mGNaj2EYcyH/CsQ9/rMyqReT8JDfuQz6z1w1gs/OMupEFWSm/4cO/GmmDIjqgfo
         Cwbgs04yO2Dv5YBbUajCQIWMFcFb2TbLTp4SwHzwEZyNELFbRH5JStrJZqYSeCHRIQ7X
         KbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760330297; x=1760935097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jQ7mGdL6AjL3n52++SuIetPTh8rjsnTvNAsGSM8T6g=;
        b=aWTF7r6fYU9TcWSq07OgGev8XpXhg7T1T2Z40PtnZCWMRjuyN7jbAmwQSb+cxRdijf
         h2yGGfKIdABVDEccQt5OdqY29luUaxIBs+euekatCrGHy08hImtOfe60mORSKLNcONEa
         mS3ebyIUfwX/y8tuzImS0PY5TdCoT0KwjmuC3vaEtHdUWNVNh3YHwkNBtB+gZCUdBWKw
         v90A4LzRlVEP668bSA3PQHSTdnfG5ud/VQgmXLoTCcOvZbZMY2aHSOrhhfAXiS38TTwe
         IcJmCBeQBAVIue4Z8DCN872rjjlfgW8mZxRR6CC5b/5zsruIbOBB5hsxz0JVF06/Bil1
         NMwA==
X-Forwarded-Encrypted: i=1; AJvYcCVZBnqNpVv1Er98ouhaw5OnI7iO5Qn2YYaM+Hew/gxLDJnMUpf0rtW4MFO8MyDJOy66mP0SaUHvhtzYgWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY96msI+wVkdHcpdBUxyH/UYxWnSMS8RlvFpbM8SQQUltu8O3Q
	nE06IeXdECIREBFWX6wuzCBBpupmihePg4ZN/BdsmHvZa/+PPt4iwiXa
X-Gm-Gg: ASbGncuFjx9mzO1TejqyuEF52uJJCAV/hVmj3O2iY4e4XFEgjEkKTP8tpAERbm0Flp+
	Lh1b+CMVlmfEBM/9vp6K/TgzBdPaz6Ox+AoyQyfF/89aOc8dDPa95yG3twW2PaX2Oeb2OjXQxz+
	ChnhlmqqNqt+ucqYVIXasg76F9tZgFa//kgcr51C3iAxbdm3HRcXDqQVrICS5esjMUltBGLa5F+
	Zcz2iJsH3F8HBT0k+DqFcCgdTNzc04EdtIo+LdAhUsWKueJtHqUJrgDbJSgA//BTrQet/O7XacJ
	cW1PMBl/J7UmwPDI5qUq3lZtpz7eLLNHDlyUm+A1IG2txhO90qdvuf8HZma6UEzhKRaCi8dixCI
	p7uIyiBf/XfqIrjJk8FYUvXwESASSsJYzys71GQ==
X-Google-Smtp-Source: AGHT+IECDsp7UtBNbkAMUan55y1XQuX+ULfYaKfSidXHic/wkkfkYOISn2UHW8fXUSR6MSLEloK7xQ==
X-Received: by 2002:a17:903:24f:b0:26b:1871:1f70 with SMTP id d9443c01a7336-2902727f94amr119251795ad.5.1760330297305;
        Sun, 12 Oct 2025 21:38:17 -0700 (PDT)
Received: from localhost ([104.249.174.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070basm120833025ad.77.2025.10.12.21.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 21:38:16 -0700 (PDT)
From: Ben Guo <benx.guo@gmail.com>
To: si.yanteng@linux.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	alexs@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dzm91@hust.edu.cn,
	gary@garyguo.net,
	hust-os-kernel-patches@googlegroups.com,
	justinstitt@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v2] docs/zh_CN: Add translation of rust/testing.rst
Date: Mon, 13 Oct 2025 04:38:10 +0000
Message-ID: <20251013043812.13186-1-benx.guo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003074939.465517-1-benx.guo@gmail.com>
References: <20251003074939.465517-1-benx.guo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yanteng,

I’d like to confirm the expected use of the In-Reply-To header for versioned patches.

In my case:
  [PATCH]    ->  Message-ID: <20250929163531.376092-1-benx.guo@gmail.com>
  [PATCH v2] ->  Message-ID: <20251003074939.465517-1-benx.guo@gmail.com>
  [PATCH v2] -> In-Reply-To: <20250929163531.376092-1-benx.guo@gmail.com>

That means the v2 patch points back to the v1 message ID.

Could you please confirm whether I should start a new thread for [PATCH v2], or if there’s something wrong with how I used the In-Reply-To header?  
Thanks for helping clarify this.

Thanks,
Ben Guo

