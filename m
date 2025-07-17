Return-Path: <linux-kernel+bounces-736064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14026B097E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F45B3AA35A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619812690E7;
	Thu, 17 Jul 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e2I/Zxow"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715826656F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794887; cv=none; b=JgHfbIIf7jqXba3D6RrNF0SSXlri1SqC8+OY/kRneIyers4uTQpb8mi0TYNzvIDKh3h/7DPlCezNDu7jrr2AXpVltg+mmajDCyYwNz2xYMfjYb7d5Kn42sM/9wTyNhR1YGFEw3OEZmI6s9yE/5KkuDeSHpepATDXyPea7n8aHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794887; c=relaxed/simple;
	bh=iAu/m/Ked4Yjj7vjRUJ1EMyr8TIJsgKEj/d7vMIV89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ//EzssOqXSvyK+JhyBUHy5du2uRa+3d5qPKQOMg81T6nx9N2Oh9EjH0bRvlc2Iz+CqA5UFl0Ng9ZzQua368vGp6989us9ysXTOyq3Wvz9bclzxpy+p36hTe7fnIwasUhqvIZxhlQP251+5k9g7R4NyamPReGvaMGqmWCrpV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e2I/Zxow; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1347497a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752794885; x=1753399685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=e2I/ZxowhVOdfWe4Qr1QfQT1dNLuEcu9Do3YtjLtn3E9MYzOkKwFFuOg9qtC6GGZZF
         T/pNRCyqYmxvroJoDEvMsk1eMtppLJh+PjmAX7G6PP6Uy2jyoc52eBNmiLuOrS/OKCg7
         RwNJfvs5nnGXWfnsLX0I57ghxJlqHmX1AbiSWCq+Lg+UTB7bFWVt3gzGDnPxd09T6R99
         MGnruGj/Q946wZqYEV1DB8yK18LLPp1/85QnRo8V1wEjnvpaaVryvGQ7V3SCy5jNffmA
         Y3Y2iLxmfiWUneLZRES1p3sysdcNci8Kta9lyNtuGooeWgxCHmJ/AXVs6M5yAmUTq1Uc
         Nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794885; x=1753399685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=K4H8I0su8HSGeEfKkGHhKizw+BabiVhdrlJyHdX9/swV2iwyY3XyIw0ViL6r2xFsCv
         dUJIHwegUeTDZD/DsQbGjauSBWh1BqkwkpiSgEHFoPGkopFlaEmAW6h9hvw4WlO96DeR
         Nnn5IMEhAMGwHriUmaX/SEnUhooqscJ4B8hb66+Bng59tdtq88RVcu2O+EBXSejQ1cvT
         c+aHJCkJbXOCKbBVXhcYaglKJY6j12zqE77pjTX0yjjy2iqL7cu5ErtiCARdUaE5XXJm
         obAHCCal+UdGgozGdLcpWol85/r0xxz7XU5x6X+o3PVGaJLJaoJePll3ZEbgTiaOXOKJ
         QR3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcFPgCCFTZjMQjsPIpEdTbv0/cz1PxJDZa47CiLqCMSQaP4gQghup9R/WWpy3qLdPyxHQ+R118tOZifnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9du48bDgs6atc9Oqk+n+yeinL5N70ht0r6oJLITUExTRhnWiF
	6yH89vUOZGR3kag4KvoQ6aloPoOZ4FApTO558bKvkBKRoNmDggcKRdawFjmXOAGOE44=
X-Gm-Gg: ASbGncu7nU841YrGWdkknVRguRMobGvFLOjItAFddfZ0eXOgjZwgd/sFCktus/7aYDC
	xzSLtlhFJrpj+9EaFmBmcDZM/VVomhTRVQy5xtkuYG/t4smmi3BhAI6SjcGUa721+HZvzDQtRy9
	57FNe0YfRHowC9HU7EYaBaIGovsEP2WzkB3cpHjf9ajPr6mNRlCvFbwkalIzuaHdmhYyl5ImzOu
	ofsfWAEZHhcPqZ6iheV/NI70HoNje846sjBUvd1BkIrSNLz7e/n/ndXw/jdsB2xKzf8bVR53bji
	higgy8rwOvUjUlHuLcw88Yh0eFsdkS7dFWMDcB+PSH9vlOnGY9OaX9dJZVezKIMaOue2/yXQJzS
	4emfZxDonC3XTeKDEbSFBUVT9Ax8gQaTaqaN4wobIc6Fwel8mgD/cBLqUZSw=
X-Google-Smtp-Source: AGHT+IE2fvU0LI5VyMAsBnS6jAOFpIF2Ch7bsj27Ceh44Xb5VQmNCAIyLSIUVF1pWxqlVk2eBTBkQw==
X-Received: by 2002:a17:90b:5105:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-31cc2544404mr1063803a91.12.1752794885293;
        Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm101318a91.0.2025.07.17.16.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:28:04 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: lukas@wunner.de
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 17:27:58 -0600
Message-ID: <20250717232758.24605-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <aHlbtTxO7mR9XfGX@wunner.de>
References: <aHlbtTxO7mR9XfGX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025, Bjorn Helgaas wrote:
> - slot_name() (which I think comes from make_slot_name(); would you
>   want something else?)

afaik it ends up coming from the Slot Cap Register "Physical Slot Number" bits.
I brought up the slot to just say that I was happy to see it & that it is useful
for our purposes & why.

On Thu, 17 Jul 2025, Lukas Wunner wrote:
>> and IIUC, it would be helpful for you to add:
>> 
>>   - DSP Vendor/Device ID (the Root Port or Switch Downstream Port,
>>     which is relatively static, so seems less useful to me than the
>>     USP/EP would be)
>
> Right, this is already logged in dmesg upon enumeration of the hotplug port,
> as well as available via lspci.

I also agree that the DSP Vendor/Device ID is less useful.

>>   - USP/EP Vendor/Device ID
>
> There's no 1:1 relation between link or presence events on the one hand,
> and enumeration of hotplugged components on the other hand:  The link
> may go up but the kernel may fail to enumerate the component, e.g. because
> it was yanked before it could be enumerated, or because the kernel has run
> out of MMIO space or bus numbers.
> 
> Hence this would have to be logged through a separate tracepoint in
> pciehp_configure_device(), not by changing the tracepoints added here.

Ok I think its reasonable to use a separate tracepoint that would have more
information about the EP.


