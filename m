Return-Path: <linux-kernel+bounces-806431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D08B496B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AE0440B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D455312801;
	Mon,  8 Sep 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOsYG0DY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287213126DB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351569; cv=none; b=P/Dfb1hkpdADLxKF4YIV9EQBCct+iWMs22JQtZFVpiHfarWQnOBIl/CbxytvUG6exdvFrzdHvV0m9mzL2QHZ2S+ZA1jklmTA9BL8AWAawE5HObaWyaVyrpmGYsW8onv20BrG4EvkxvZ+Yqzn57SWqTErN/jlUXNBD+/APHa7vSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351569; c=relaxed/simple;
	bh=9wENXREJWltOZIo5LsFs5L8jitKtQe8nqAyfDbsl9ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw8I7fFn0px4vXZy/VDA6MpX1ntZkseJZjfNsRG5Gl7Th+80CGQyMShCvp1VJLDMYCfBf/pDieDuO1p8Es0PAMkry0nmqikEy8dunu9xxhigE7rYDS50gxP2jRu0UR1XRCwuTkAp5ZlS9aChwLqa3tKhfcLLRXgJSZ6mZIA0d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOsYG0DY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757351567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ITe2If+kWs1Wpx5tlRiHNQVWbTASg/lvnSb0pDekYg=;
	b=DOsYG0DYxinBpThkxeAHTXfscqm7n+RGzdX1yvnZINwFaIDYjKOi4hIc5wasB6Dn/WcJni
	ASm6Pxkjc8UISk7/4shO8ZSbBMtlj4BBojtOtf0mhKt3YwL9cXGkIqwiOMzKK0/WQNQC0m
	nYodxerG+O3r/7ywFRNGdik8s8d3iK8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-2d0c7X_SOkeQx0fyaLYZlw-1; Mon, 08 Sep 2025 13:12:45 -0400
X-MC-Unique: 2d0c7X_SOkeQx0fyaLYZlw-1
X-Mimecast-MFC-AGG-ID: 2d0c7X_SOkeQx0fyaLYZlw_1757351565
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870614b86so1571904885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351565; x=1757956365;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ITe2If+kWs1Wpx5tlRiHNQVWbTASg/lvnSb0pDekYg=;
        b=emIN8mR45Nc+iTPNbLeui/XWbZ/bBqIulat+HNyxb5YQV80i3cT0X9OSH2bgPBhm1J
         jrfZklXGFkJ/337c5Z1JBfhaY4IcwfZkTrQFbd0zjFV79dF3MgMIwqy2J5UVj2yMDOh0
         7Bc9exQQJjwxw7bpMWM6I+Lzm0t7XaObcLyWE/6T5+GsJEDaQ9zIkI6ziIdlB+su7oU0
         J1sNjXnwYXApaIoVYYz7TQfEmwtyS8iu9KBU7cg9//EUWtt6BPl+9FYece+KcdxrXFoZ
         KqEIJyEhgbZFyjEdWUGCSWeg5lV9vmRegWDYHF5LgPVK1MDOLpo0YYJh1HrCkW9V9r3u
         m/jA==
X-Forwarded-Encrypted: i=1; AJvYcCW1WCGlryHYI5Xo3MAJ3OGW5ScgoVc/ItF+KRRk2CglQPirKjWebZmHw5GQwduOHm3v55NklGHs+l8yuAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4rJLSVj7LQhCRptSa77etkCBM2dkXVl72diE/pNB0VZv3KbZ
	CpQpFXbcvvYEPAkhVbsKXIbDgdiVVjL+ZdRbBDw1+/ymsTDkFJvkzQlRVU7NkqHtGO9j9pdB4Hl
	pKwFKAJ3saXx0YGtTi1ljg1EHmBfv7BOWgTfLtOOGCTpY6qAOQ3PzyxAb7D/xetpZTg==
X-Gm-Gg: ASbGncsF62chy/vTTNZC2hIuBP3Evk6PI3IVSfJ3JxBScosfsa5blgP0x19Zbof1gLj
	tZhE2ZZBg1tD4oQe6ad567f3UuKD3dL3ZXutHZIZS/5WQMABOgyP+E6JVkHTTR3yun4YB3ykxuG
	W2MI8G7pAe/Z0WpD7oRtqbsa9O0ZKy9KeMbpibls8BqVJAIE4KoNMWX/4U1XU3aRjjKW1rYSvei
	0XGBAPLEvILhS2OVVktlwL0T2vaFH1qUYcTL4k04hYm1WUioKyvshA+d/jQLmidu7O4+MN0JIwk
	yhxibvCw5lKCnwOXmRyu00AJGqtSZEG6/zxpnaltK3HmovvH3uRfo5DQ2vE=
X-Received: by 2002:a05:620a:4714:b0:7e8:3fbd:4190 with SMTP id af79cd13be357-813bdf6a9c8mr829190385a.2.1757351564631;
        Mon, 08 Sep 2025 10:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMZsEl4SQNKbeMqNXOZc4NyVlPYCi+ENDx/Vjfad/o+tQQ/qJhvSwRqRuWnLNVWOHla1Uqg==
X-Received: by 2002:a05:620a:4714:b0:7e8:3fbd:4190 with SMTP id af79cd13be357-813bdf6a9c8mr829186285a.2.1757351564056;
        Mon, 08 Sep 2025 10:12:44 -0700 (PDT)
Received: from x1 ([2600:382:8507:870e:b6f8:ee72:4f09:a16a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8138798dfcesm600461485a.34.2025.09.08.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:12:43 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:12:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: scmi: migrate round_rate() to determine_rate()
Message-ID: <aL8Oifz8zR9nJ_Wg@x1>
References: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Aug 27, 2025 at 01:12:07PM -0400, Brian Masney wrote:
> This driver implements both the determine_rate() and round_rate() clk
> ops, and the round_rate() clk ops is deprecated. When both are defined,
> clk_core_determine_round_nolock() from the clk core will only use the
> determine_rate() clk ops.
> 
> The existing scmi_clk_determine_rate() is a noop implementation that
> lets the firmware round the rate as appropriate. Drop the existing
> determine_rate implementation and convert the existing round_rate()
> implementation over to determine_rate().
> 
> scmi_clk_determine_rate() was added recently when the clock parent
> support was added, so it's not expected that this change will regress
> anything.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

I included this patch in this pull request to Stephen:
https://lore.kernel.org/linux-clk/aL8MXYrR5uoBa4cB@x1/T/#u

Brian


