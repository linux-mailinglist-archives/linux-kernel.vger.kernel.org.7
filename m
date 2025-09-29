Return-Path: <linux-kernel+bounces-835753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A4BA7FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D84189A556
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC22206AC;
	Mon, 29 Sep 2025 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KmkKHAqe"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42E86323
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122728; cv=none; b=TY5RNJkcvH4dd22e6RLo7U07WFrxm2JloSTItCl7SvL51JjrfrqA/eR0KBm32BGQ4Sl9b4Z4SVA0zLJcGRqopULOWy7ynjcKsCQxag5mdO8K2BJPpY16hGFv9f3TIdPJuOiNbrT3S29dTZ+IJxR1Jcb4Wr1jkHy1FRBLVMhMfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122728; c=relaxed/simple;
	bh=0XTRWZOjXqYW6GqQmb1jA9TX+kNpX4Zm5F9lrOh6K5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=HS8nKsUidnk7viY5MTX5GHAt03uWwiaf4fXOdNKvd/V76gw7dhEKHBEWY/J4na47sB5DS+v1v6/4oIZ1fN7aqfnpw/tUtpM2Kj/52ZwZge8215Fn4DlZ1/6FUWMNx+dmZUJMUvaSMF+6bW0RE0t+KGiPHAfd5yNpzrUDw7BUkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KmkKHAqe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b40884aeaf4so1450566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1759122724; x=1759727524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RyDjxJS1pH40ad63X5Di6by1390Eb9+O2bEzEpM7efE=;
        b=KmkKHAqe/oYSALsUWogPICpNF/GnQOKXUvJDupoSbx0Zam1LAQ0YmO5Qe557DE08M/
         LkmcInUx7/BwH/5q0yMMX+4dOlwc0gJh1alKKu24+czwpjW9XaoD9Gs3vpDdWpYJQxow
         xkcBoNB+X+dAtPe3V8GhVPTTw1mkM1oosw6wbTKWjS4zef81YCHAp5QDteDMUsycFQ0q
         jIAVPZgqo0knm00e9IKOWlAY0v6vROOfk/ep4Ja+0VHlYMPIqu1eJMM6IEfRP545ZoNq
         oUFbT7DZr51N8H+GxWtlpZZyvMu8RxVoqe+hbrJ9ytV2IKLtIXHbwkgcjNtK1aswdLh3
         3kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759122724; x=1759727524;
        h=content-transfer-encoding:content-disposition:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyDjxJS1pH40ad63X5Di6by1390Eb9+O2bEzEpM7efE=;
        b=KOUeg4UVI80dE7+AeTH2UMx4umfDLZAQPU0Zl2q9pTBA3kwz9sTNTQ3TFeTgdnYxfv
         kLELQ5UmgMdai+DnRD35ZBxIMUgXIFYTVPIgKQRRCipHVppMT402eG8pMVDg6i5NLRNX
         8dD5kitH5X9wNYnHUzLdISO8Tykb5UX3LqB3cMMrJwTtW23hS6lJwbnOqXZAT6f4ZUVB
         R+Mw2IsyNqJZCkrZ+tM22GHcJeejlu5wEWItMfFKxWL3b6pocfIt0+VMPzU/74sJiQC5
         M0oOxr/bKYRFFMNKGCWKz05LxxsAxkGy/LpkDmqFfDOfuql4pC0vk/8Tfu21lS0HqOtd
         DlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTa4NZwpSD6FEfUhuzp5BTFsm5r0YfPkg/9TxEIEB1npslh0IP16bwEB+7Tpz8aM5KpThVXyzXl8TmgS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtC9EacG7sjM3pyzOYsrzO7nbRd0UVgBM6GY0bNtqlzOczTh1
	KprOj194ByklPy0BgvoolfuYnlNkYZq/hRTx3RATMfmkUEx05Tyen7j8MoHR4IAGzGz6AX0XsW6
	MYjb4dzY=
X-Gm-Gg: ASbGncuFYHSZs860fG4MvOLuX83Cy2VBkqbRrVgk2GRCMbkAgY4rjm71vKnq4rQV6Hq
	NhdN20zJhduuH3oaX33T4bwGBp9aNcDcMg2KclDyGAmdwiFj19X/TExDBygSij+U7KRQ/bd3vZu
	X3LRmQ0cLVvvqwNmjt3+LirEf/jYN2JsQSrLTRz18cpzZBNVkNN38Q20o02J/cgNI/aFHA3VlO6
	xH0fXuQdTREBqhDwcP5oIcbfjNkEWt5sqpUkQ87UknCa858zYBWAUtDT/wr7xOdHKrgerqaVECh
	pfL8eff3VZgqG2Bq7IenfOvXiUJ2taxFcZ18OYbiZnWsQnLhdRR8zn8UUOVldQzJH998NY1VPDN
	rKRH18aq9Eh+P4DDmHvXN5qGoBU4tAaWh6tCyFPNKw9Y=
X-Google-Smtp-Source: AGHT+IGJrG5UeHbZ1lxXkb4X5YIcyHBYAq5V/R7Uf6AS3qWqMZLonPpzBVytosQVDGMiGJP+Qer4Ug==
X-Received: by 2002:a17:907:96a1:b0:b04:7f7f:4d7a with SMTP id a640c23a62f3a-b34beca15e3mr841408166b.10.1759122724503;
        Sun, 28 Sep 2025 22:12:04 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:146c:c500:c2f7:bbda:f199:5aab])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3a835ca898sm420104466b.60.2025.09.28.22.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:12:04 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: pawan.kumar.gupta@linux.intel.com,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: asit.k.mallick@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tao1.zhang@intel.com
Subject: [PATCH 0/2] VMSCAPE optimization for BHI variant
Date: Mon, 29 Sep 2025 07:12:03 +0200
Message-ID: <20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com>
References: <20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com>
X-Change-ID: 20250916-vmscape-bhb-d7d469977f2f
X-Mailer: b4 0.14.2
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Hi Pawan,

Thx for the patches, I tested them on our Intel SierraForest machine with fio
4k randread/randwrite from guest, qemu virtio-blk, noticed nice performance
improvement comparing to the default IBPB before exit to userspace mitigation.
eg with default IBPB mitigation fio gets 204k IOPS, with this new Clear BHB before exit to userspace 
gets 323k IOPS.

Thx!

