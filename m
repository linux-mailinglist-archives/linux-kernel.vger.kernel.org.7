Return-Path: <linux-kernel+bounces-844554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720BBC2342
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046FB4F78D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC832E8B67;
	Tue,  7 Oct 2025 16:56:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1C2E8B72;
	Tue,  7 Oct 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856166; cv=none; b=O4AZwS1NVOsEPMwMqRF1MdRPMBQn8bp2zKV21qzwDqssYmBnA7EIlv4Dmv8dQdomo+TxWls88cmVNitx2vAaMEkAGdimC2vfdyLMYzMsfMnQ9bzVE9ImdmDG64Ha5aE46z54RdmYclBnNE8ptP8SwbwjoJTlL1fLudnkZ2lvK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856166; c=relaxed/simple;
	bh=gfsRgQcJXK20Eta/1P3saMmYQrhBRKf3OvIgbzPgE8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndX1E/QjwmnhqJ+uW5U/5iViSgy1pK7+zkboFKR9LImAm4SweSeCdKnbWb0c9cNrPTLJsNmmoZnM9kZHWMFm6MuJL3n2hUKDPWZ8HYTrZzaGR9/j/2gr8gC07iMhqeodJPC/3xL9Gqfd/Rqd6JWNhUiCaWfSYSfHV6t+Js7gdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89BC106F;
	Tue,  7 Oct 2025 09:55:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1996B3F66E;
	Tue,  7 Oct 2025 09:56:01 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:55:53 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: scmi: Add completion timeout handling for
 raw mode transfers
Message-ID: <aOVGGaY9NmKqUwPG@pluto>
References: <20250929142856.540590-1-a.shimko.dev@gmail.com>
 <20251003192233.1618447-1-a.shimko.dev@gmail.com_quarantine>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003192233.1618447-1-a.shimko.dev@gmail.com_quarantine>

On Fri, Oct 03, 2025 at 10:22:33PM +0300, Artem Shimko wrote:
> Fix race conditions in SCMI raw mode implementation by adding proper
> completion timeout handling. Multiple tests in the SCMI test suite
> were failing due to early clearing of SCMI_XFER_FLAG_IS_RAW flag in
> scmi_xfer_raw_put() function.

Hi Artem,

LGTM now .... but ... now the commit message is no more describing what you
are doing, right ? ... it is no more handled with completions...

Please fix the commit message to reflect what you are doing; also it
would be good to at first explain the issue (like you are doing
already), and THEN describe the solution applied...

Following the rules in "Describe your changes" in:

	https://www.kernel.org/doc/html/v6.17/process/submitting-patches.html

(if you already know this ... just ignore me)

> 
> TRANS=raw
> PROTOCOLS=base,clock,power_domain,performance,system_power,sensor,
> voltage,reset,powercap,pin_control VERBOSE=5
> 
> The root cause:
> Tests were failing on poll() system calls with this condition:
>     if (!raw || (idx == SCMI_RAW_REPLY_QUEUE && !SCMI_XFER_IS_RAW(xfer)))
>         return;
> 
> The SCMI_XFER_FLAG_IS_RAW flag was being cleared prematurely before
> the transfer completion was properly acknowledged, causing the poll
> to return on timeout and tests to fail.
> 
> Fix ensures:
> - Proper synchronization between transfer completion and flag clearing
> - Stable test execution by maintaining correct flag states
> 
> An example of a random test failure:
>  817: Voltage get ext name for invalid domain
>      [Check 1] Get extended name for invalid domain
>        MSG HDR        : 0x04585c09
>        NUM PARAM      : 1
>        PARAMETER[00]  : 0x0000000c
>        CHECK STATUS   : PASSED [SCMI_NOT_FOUND_ERR]
>        CHECK HEADER   : PASSED [0x04585c09]
>        RETURN COUNT   : 0
>        NUM DOMAINS    : 11
>        VOLTAGE DOMAIN : 0
>      [Check 2] Get extended name for unsupp. domain
>        MSG HDR        : 0x045c5c09
>        NUM PARAM      : 1
>        PARAMETER[00]  : 0x00000000
>        CHECK STATUS   : FAILED
>            EXPECTED   : SCMI_NOT_FOUND_ERR
>            RECEIVED   : SCMI_GENERIC_ERROR  : NON CONFORMANT
> 
> After making these changes, the tests stopped failing.
> 

I think also you can trim and drop this further explanation down here...
you have described clearly enough the issue above...

> $mount -t debugfs none /sys/kernel/debug
> $scmi_test_agent
> [  127.865032] arm-scmi arm-scmi.1.auto: Resetting SCMI Raw stack.
> [  128.360503] arm-scmi arm-scmi.1.auto: Using Base channel for protocol 0x12
> $tail -n 6 arm_scmi_test_log.txt
> ****************************************************
>   TOTAL TESTS: 167    PASSED: 120    FAILED: 0    SKIPPED: 47
> ****************************************************
> 
> An ftrace log with of passed test:
> 0)               |  scmi_rx_callback()
> 0)               |    scmi_raw_message_report()
> 7)               |    scmi_xfer_raw_wait_for_message_response()
> 7) + 22.000 us   |      scmi_wait_for_reply();
> 0)               |        /* scmi_raw_message_report*/
> 7)               |    scmi_xfer_raw_put()
> 
> An ftrace log with of failed test:
> 0)               |  scmi_rx_callback() {
> 0)               |    scmi_raw_message_report()
> 5)               |    scmi_xfer_raw_wait_for_message_response()
> 5) ! 383.000 us  |      scmi_wait_for_reply();
> 5)               |    scmi_xfer_raw_put() {
> 0)               |  /* scmi_raw_message_report*/
> 
> Link [1] https://gitlab.arm.com/tests/scmi-tests/-/releases
> 
> Fixes: 3095a3e25d8f7 (firmware: arm_scmi: Add xfer helpers to provide raw access)
> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
> Hi Cristian,
> 
> Good point about CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX. 
> 
> I can confirm this setting doesn't impact the test failures in my environment.
> The issue reproduces consistently with COEX both enabled and disabled.
> 
> Thank you!
> 

Good...

Thanks to you
Cristian

