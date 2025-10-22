Return-Path: <linux-kernel+bounces-865481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0CBFD58D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CDF3ADB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D746285C9F;
	Wed, 22 Oct 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="N81VK2bz"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AB25DCE0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149549; cv=none; b=df3OYVVfM4iq20Xw1os5JqkexRykTYK8uZHg0xHCQYOR3dqUHeAQpZBOMSMgidRNCqHtMrIolNu1JlGbvqCPP8VzNoxMh+oeS2IL6TkVRV/9IvVQ+Yrimd7LmGsNbZcema/y2uOEb7RSxAVP9NzaiFCUnaEM4svCR1Ellb+7Ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149549; c=relaxed/simple;
	bh=gqwSA2NSehrIkiAa3MvpQ0YrHVz97jJfVltxRd6ifCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCIfFJ+QU8UT8wEQm2d0WiyhJGLKZMZxHVm0uxS14E/Ysth4Znp8pbNZU8OMFnAMegaxh8j8zfVqPjv7o8W9mUji/kSNSOPOHnx/Fqiqd6lbTLB3nQ8t5fVlWK6CdFOzUqv0gjobEw3DGjaccSyL0HltstxTBzO1r6s5r/nKHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=N81VK2bz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a27053843bso575021b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761149546; x=1761754346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM7M30VT9M3+HwGFICpWImyB+LRqQz/+UE5BheMmog0=;
        b=N81VK2bzHprvQ3GkkLFQirp+suoqT8ljfiqN7v5fYFTAnlNQH9CGGcpCzk+galDFG3
         n4N6iHRM9IQPbb0qHMiA3DyP6nftcx/wEy5KMvED89WsjELDnwe+9s4//eGxQIdt+z9V
         19KM/DrhuqV8RQaxBxPMPu8NOqUV/5M7rD0N7shwGgEKb88Tr8hKczB4nHkqlpHE1lgQ
         wMFAm4bircKNnaxOttB3ldb5uiE6SO1V7OTkiREKUrRXYrfv6TvtlNLPA28auyDNz9By
         oC7/qpj4O27W9dz+awvrvj+HDB1IUP3Q0M0mezZxQQ7sx/IrAvOzjCO7crycfq8tykwl
         VSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149546; x=1761754346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM7M30VT9M3+HwGFICpWImyB+LRqQz/+UE5BheMmog0=;
        b=wQApQ2qt3W9upzEKd7kA2zMOcyW+LEVnV5gCyJ3yhfjZHTkjAVvqPH7n1tTPpJPeF/
         NyJI2XQ4/XgfNDre9mcP8U2DfZdYc8/hPK94O5GUm2HIyagbiWSDi46fIJxcnvC2R1e/
         DcjNpvmAogldh9rSnxiBfJvCEFfYrKLjKYjoKuhbLuN5mJAQT5BIAN+tUeSadfwiNYRb
         Ilq6/7iFooV8NOQpx1Fqv5Wd1A+JJBkYNuIlVnw5f70WGUu0dVCqPA709thbBvBnAe6A
         bfCdqyhtv96r6kdZmUuTdvNb+IlqsDwj3Q7A6xBZYlLCQAVPDfly73Op+e881SXYc3hI
         yJaA==
X-Forwarded-Encrypted: i=1; AJvYcCX0LjiR6iZ8dDVJ/KLqkWgxO32oMrjAWXD7SK7YnKRCWLWqf1f0XK4Lcb0wBuCW2zQsUpR9e/ByMj9a7Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz355ErorWd/ANcfkvObKQ8I9VAa6RZSy7mJhd91iqA2TYhT0gV
	7xfzo83Kna2fQ8jA63TEqodNerZk9KIsEVnwXx74J/aud9XRIu6QhNuJ3eM6bqbYgNI=
X-Gm-Gg: ASbGncsBiO6OBokQ0d7VLTD6Zq+QivGFfaFty73x/JIuY2n2yveFWdaw+wbXvtzY5Y2
	pPHdSoEz7iWRcoS4utVaDkn5zv9aUfIt98IhQsoXXsXl0igjAgG9Q29410tF+AZPD20mI9VT3OS
	VaX0Oo3f+stfuu1APAFugMja61qdchgYlBRa3j9mWmIi19gu11a94Poitjg5Gh1a4De3lfVufjv
	UczVteDPVUr2bUOELiJC8mttZQBBojGIiovFOr4fZngd9SmQMf0ogfkri1Tsr4iGePkMLmpQYt2
	ymRrQoW7LQiTARd+I+HaQrLG1iCshDcKV+x0+SCoh3HqeIFf48/SIL8l793PUcx6bT/r8tpGa4Q
	ZA1LvzNzIefeHqJV/vJRHyAsG/4GYe3yFP+wqKwUaPoFz9/8PJxHU9hwgt3aXqoqjqRQ3CsSksl
	bTLw==
X-Google-Smtp-Source: AGHT+IHAKlv6OU0AJV6MvCP+PY0I9VRkkJMDbQuwL+3clij5MJgkRtjbaZqYfIRfeFgFO0QJzxewCg==
X-Received: by 2002:a05:6a20:3956:b0:262:8422:5774 with SMTP id adf61e73a8af0-334a85a5543mr31397680637.39.1761149546038;
        Wed, 22 Oct 2025 09:12:26 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5a007sm13166808a12.31.2025.10.22.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:12:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:12:23 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPkCZ8l4-5ffyiAe@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
 <aPf5DZVYrc2YAXXT@mozart.vkv.me>
 <aPf7Vz5K6P7frdlf@mozart.vkv.me>
 <2569250.XAFRqVoOGU@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2569250.XAFRqVoOGU@fedora.fritz.box>

On Wednesday 10/22 at 00:07 +0200, Francesco Valla wrote:
> On Tuesday, 21 October 2025 at 23:29:59 Calvin Owens <calvin@wbinvd.org> wrote:
> > On Tuesday 10/21 at 14:20 -0700, Calvin Owens wrote:
> > > On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> > > > Hello,
> > > > 
> > > > while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> > > > Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> > > > 
> > > > While the firmware download always completed without errors, subsequent HCI
> > > > communication would fail most of the time with:
> > > > 
> > > >     Frame reassembly failed (-84)
> > > > 
> > > > After some debug, I found the culprit to be this patch that was integrated as
> > > > part of the current (v6.18) cycle:
> > > > 
> > > >     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> > > > 
> > > > The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> > > > used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> > > > that the private drvdata for the input struct hci_dev is a pointer to a
> > > > struct hci_uart, but that's not the case for the btnxpuart driver. In this
> > > > case, the information about padding and alignment are pretty random and
> > > > depend on the content of the data that was incorrectly casted as a
> > > > struct hci_uart.
> > > > 
> > > > The bug should impact also the other platforms that were touched by the
> > > > same patch. 
> > > 
> > > Hi Francesco,
> > > 
> > > Thanks for investigating, this makes sense to me.
> > > 
> > > Funny enough, I specifically tested this on btnxpuart and saw no
> > > problems. I suppose some kconfig difference or some other innocuous
> > > patch moved structure fields around such that it triggered for you?
> > > Not that it really matters...
> > > 
> > > > For the time being, I'd then propose to revert the commit.
> > > 
> > > Adding back all the duplicate code is not the right way forward, IMHO.
> > > There must be some way to "mask" the problematic behavior for the
> > > drivers which stash the different structure in drvdata, right?
> > 
> > Actually, the right approach is probably to tweak these drivers to do
> > what the Intel driver does:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bluetooth/hci_intel.c#n869
> > 
> >     static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> >     {
> >             struct hci_uart *hu = hci_get_drvdata(hdev);
> >             struct intel_data *intel = hu->priv;
> > 
> > I'll spin that up unless I hear better from anyone else :)
> >
> 
> Hi, thanks for the quick response!
> 
> That was my first thought, but the Intel driver actually _uses_ the hci_uart
> structure, while btnxpuart and such would only piggy-back on it to be able to
> use h4_recv_buf() (and struct hci_uart is huge!).

Why is that a problem? Certainly, nobody is going to mind the extra
bytes with that monstrosity hanging around :)

> One possible solution would be to define an "inner" __h4_recv_buf() function
> that accepts alignment and padding as arguments, and use that directly on
> drivers that don't use struct hci_uart (PoC attached - I don't like the
> __h4_recv_buf name but I don't really know how it should be called).

I don't feel super strongly about it, but IMHO the whole thing is easier
to understand if we just put the data the core function expects where it
expects it. I haven't had enough coffee yet, but I think
zero-initializing hu is sufficient...

Something like this, only compile tested:
---8<---
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] Working bugfix for bt cleanup, only for btnxpuart for now

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/btnxpuart.c | 74 +++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index d5153fed0518..cf464515c855 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -212,6 +212,7 @@ struct btnxpuart_dev {
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
+	struct hci_uart hu;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -363,6 +364,12 @@ union nxp_set_bd_addr_payload {
 
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
+static struct btnxpuart_dev *hci_get_nxpdev(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	return hu->priv;
+}
+
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
 #define DEFAULT_PS_MODE		PS_MODE_ENABLE
@@ -373,7 +380,7 @@ static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
 					void *param,
 					bool resp)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	struct sk_buff *skb = NULL;
 
@@ -426,7 +433,7 @@ static void ps_cancel_timer(struct btnxpuart_dev *nxpdev)
 
 static void ps_control(struct hci_dev *hdev, u8 ps_state)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	int status = 0;
 
@@ -483,7 +490,7 @@ static void ps_timeout_func(struct timer_list *t)
 {
 	struct ps_data *data = timer_container_of(data, t, ps_timer);
 	struct hci_dev *hdev = data->hdev;
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	if (test_bit(BTNXPUART_TX_STATE_ACTIVE, &nxpdev->tx_state)) {
 		ps_start_timer(nxpdev);
@@ -502,7 +509,7 @@ static irqreturn_t ps_host_wakeup_irq_handler(int irq, void *priv)
 }
 static int ps_setup(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
 	int ret;
@@ -597,7 +604,7 @@ static void ps_cleanup(struct btnxpuart_dev *nxpdev)
 
 static int send_ps_cmd(struct hci_dev *hdev, void *data)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	struct psmode_cmd_payload pcmd;
 	struct sk_buff *skb;
@@ -636,7 +643,7 @@ static int send_ps_cmd(struct hci_dev *hdev, void *data)
 
 static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	struct wakeup_cmd_payload pcmd;
 	struct sk_buff *skb;
@@ -682,7 +689,7 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 
 static void ps_init(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	u8 default_h2c_wakeup_mode = DEFAULT_H2C_WAKEUP_MODE;
 
@@ -732,7 +739,7 @@ static void ps_init(struct hci_dev *hdev)
 /* NXP Firmware Download Feature */
 static int nxp_download_firmware(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	int err = 0;
 
 	nxpdev->fw_dnld_v1_offset = 0;
@@ -782,7 +789,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 
 static void nxp_send_ack(u8 ack, struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	u8 ack_nak[2];
 	int len = 1;
 
@@ -796,7 +803,7 @@ static void nxp_send_ack(u8 ack, struct hci_dev *hdev)
 
 static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct nxp_bootloader_cmd nxp_cmd5;
 	struct uart_config uart_config;
 	u32 clkdivaddr = CLKDIVADDR - nxpdev->boot_reg_offset;
@@ -846,7 +853,7 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 
 static bool nxp_fw_change_timeout(struct hci_dev *hdev, u16 req_len)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct nxp_bootloader_cmd nxp_cmd7;
 
 	if (req_len != sizeof(nxp_cmd7))
@@ -899,7 +906,7 @@ static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
 static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name,
 				const char *fw_name_old)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	const char *fw_name_dt;
 	int err = 0;
 
@@ -931,7 +938,7 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name,
 /* for legacy chipsets with V1 bootloader */
 static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct v1_start_ind *req;
 	__u16 chip_id;
 
@@ -956,7 +963,7 @@ static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct btnxpuart_data *nxp_data = nxpdev->nxp_data;
 	struct v1_data_req *req;
 	__u16 len;
@@ -1065,7 +1072,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 					 u8 loader_ver)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	char *fw_name = NULL;
 
 	switch (chipid) {
@@ -1139,7 +1146,7 @@ static char *nxp_get_old_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct v3_start_ind *req = skb_pull_data(skb, sizeof(*req));
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	const char *fw_name;
 	const char *fw_name_old;
 	u16 chip_id;
@@ -1163,7 +1170,7 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_req *req)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	__u32 offset = __le32_to_cpu(req->offset);
 	__u16 err = __le16_to_cpu(req->error);
 	union nxp_v3_rx_timeout_nak_u timeout_nak_buf;
@@ -1191,7 +1198,7 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
 
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct v3_data_req *req;
 	__u16 len = 0;
 	__u16 err = 0;
@@ -1277,7 +1284,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	__le32 new_baudrate = __cpu_to_le32(nxpdev->new_baudrate);
 	struct ps_data *psdata = &nxpdev->psdata;
 	struct sk_buff *skb;
@@ -1362,7 +1369,7 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_acl_hdr *acl_hdr = (struct hci_acl_hdr *)skb_pull_data(skb,
 									  sizeof(*acl_hdr));
 	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
 	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
 	int err;
@@ -1439,7 +1446,7 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	char device_string[30];
 	char event_string[50];
@@ -1475,7 +1482,7 @@ static int nxp_setup(struct hci_dev *hdev)
 
 static int nxp_post_init(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
@@ -1491,7 +1498,7 @@ static int nxp_post_init(struct hci_dev *hdev)
 
 static void nxp_hw_err(struct hci_dev *hdev, u8 code)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	switch (code) {
 	case BTNXPUART_IR_HW_ERR:
@@ -1505,7 +1512,7 @@ static void nxp_hw_err(struct hci_dev *hdev, u8 code)
 
 static int nxp_shutdown(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct sk_buff *skb;
 	u8 pcmd = 0;
 
@@ -1529,7 +1536,7 @@ static int nxp_shutdown(struct hci_dev *hdev)
 
 static bool nxp_wakeup(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	if (psdata->c2h_wakeupmode != BT_HOST_WAKEUP_METHOD_NONE)
@@ -1540,7 +1547,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
 
 static void nxp_reset(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	if (!ind_reset_in_progress(nxpdev) && !fw_dump_in_progress(nxpdev)) {
 		bt_dev_dbg(hdev, "CMD Timeout detected. Resetting.");
@@ -1550,7 +1557,7 @@ static void nxp_reset(struct hci_dev *hdev)
 
 static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
@@ -1561,7 +1568,7 @@ static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 	struct hci_command_hdr *hdr;
 	struct psmode_cmd_payload ps_parm;
@@ -1693,7 +1700,7 @@ static void btnxpuart_tx_work(struct work_struct *work)
 
 static int btnxpuart_open(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	int err = 0;
 
 	err = serdev_device_open(nxpdev->serdev);
@@ -1708,7 +1715,7 @@ static int btnxpuart_open(struct hci_dev *hdev)
 
 static int btnxpuart_close(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	serdev_device_close(nxpdev->serdev);
 	skb_queue_purge(&nxpdev->txq);
@@ -1722,7 +1729,7 @@ static int btnxpuart_close(struct hci_dev *hdev)
 
 static int btnxpuart_flush(struct hci_dev *hdev)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 
 	/* Flush any pending characters */
 	serdev_device_write_flush(nxpdev->serdev);
@@ -1784,7 +1791,7 @@ static const struct serdev_device_ops btnxpuart_client_ops = {
 
 static void nxp_coredump_notify(struct hci_dev *hdev, int state)
 {
-	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	char device_string[30];
 	char event_string[50];
@@ -1877,7 +1884,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	nxpdev->hdev = hdev;
 
 	hdev->bus = HCI_UART;
-	hci_set_drvdata(hdev, nxpdev);
+	hci_set_drvdata(hdev, &nxpdev->hu);
+	nxpdev->hu.priv = nxpdev;
 
 	hdev->manufacturer = MANUFACTURER_NXP;
 	hdev->open  = btnxpuart_open;
-- 
2.47.3

