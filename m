Return-Path: <linux-kernel+bounces-881418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B03C28291
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2827940218D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AA24DCE6;
	Sat,  1 Nov 2025 16:24:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2529224AE6;
	Sat,  1 Nov 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014291; cv=none; b=tNXfU7DEUGmEDNPqjKjhzbWXysRVVWPszuZir1lgoZnhOuhJDQ99Wtasji/RzLr+9K0kK2PMBnpZJy12Le7wbeIRyBIt+6aJhKEMvzm+GcQvj+z4oSRfLcb36yvizi1qk5YgDsRUJ1OkI6YQ+EfMF71H7TAiS56HVsDwc8G6qQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014291; c=relaxed/simple;
	bh=mXqPYfYw9esG1ib211VZSuWGPUTcOUBNT+kvWwKlaY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfMPOW/y/nZj2HpgMrIWf1ewMKMgisVAB6TN7pRRDmDb+Qzf2GhYgBdSUG+27MpGiOysiIRmc/IYXVtCf4KBy6h0X58oOZCzBP+KVcwG+U5pYjxq67JfZ932JKzNDlEtWXhvuUKa8bYoS32lr0ojrUoVGssIX0ZLb29UvFrbC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af736.dynamic.kabel-deutschland.de [95.90.247.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 020BF61CC3FE8;
	Sat, 01 Nov 2025 17:24:18 +0100 (CET)
Message-ID: <88de4c86-8696-42d2-a9a5-192202c6d90e@molgen.mpg.de>
Date: Sat, 1 Nov 2025 17:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV
 address type confusion
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 jukka.rissanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
 <0d953f217feaafb4ba40281c3ab87e18ad28bae7.1761998763.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0d953f217feaafb4ba40281c3ab87e18ad28bae7.1761998763.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.

Am 01.11.25 um 13:09 schrieb Pauli Virtanen:
> Bluetooth 6lowpan.c confuses BDADDR_LE and ADDR_LE_DEV address types,
> e.g. debugfs "connect" command takes the former, and "disconnect" and
> "connect" to already connected device take the latter.  This is due to
> using same value both for l2cap_chan_connect and hci_conn_hash_lookup_le
> which take different dst_type values.
> 
> Fix address type passed to hci_conn_hash_lookup_le().
> 
> Retain the debugfs API difference between "connect" and "disconnect"
> commands since it's been like this since 2015 and nobody apparently
> complained.
> 
> Fixes: f5ad4ffceba0 ("Bluetooth: 6lowpan: Use hci_conn_hash_lookup_le() when possible")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>   net/bluetooth/6lowpan.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index f1d29fa4b411..0d8c2e2e9a6c 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -957,10 +957,11 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
>   }
>   
>   static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
> -			  struct l2cap_conn **conn)
> +			  struct l2cap_conn **conn, bool disconnect)
>   {
>   	struct hci_conn *hcon;
>   	struct hci_dev *hdev;
> +	int le_addr_type;
>   	int n;
>   
>   	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
> @@ -971,13 +972,32 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
>   	if (n < 7)
>   		return -EINVAL;
>   
> +	if (disconnect) {
> +		/* The "disconnect" debugfs command has used different address
> +		 * type constants than "connect" since 2015. Let's retain that
> +		 * for now even though it's obviously buggy...
> +		 */
> +		*addr_type += 1;
> +	}
> +
> +	switch (*addr_type) {
> +	case BDADDR_LE_PUBLIC:
> +		le_addr_type = ADDR_LE_DEV_PUBLIC;
> +		break;
> +	case BDADDR_LE_RANDOM:
> +		le_addr_type = ADDR_LE_DEV_RANDOM;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>   	/* The LE_PUBLIC address type is ignored because of BDADDR_ANY */
>   	hdev = hci_get_route(addr, BDADDR_ANY, BDADDR_LE_PUBLIC);
>   	if (!hdev)
>   		return -ENOENT;
>   
>   	hci_dev_lock(hdev);
> -	hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
> +	hcon = hci_conn_hash_lookup_le(hdev, addr, le_addr_type);
>   	hci_dev_unlock(hdev);
>   	hci_dev_put(hdev);
>   
> @@ -1104,7 +1124,7 @@ static ssize_t lowpan_control_write(struct file *fp,
>   	buf[buf_size] = '\0';
>   
>   	if (memcmp(buf, "connect ", 8) == 0) {
> -		ret = get_l2cap_conn(&buf[8], &addr, &addr_type, &conn);
> +		ret = get_l2cap_conn(&buf[8], &addr, &addr_type, &conn, false);
>   		if (ret == -EINVAL)
>   			return ret;
>   
> @@ -1141,7 +1161,7 @@ static ssize_t lowpan_control_write(struct file *fp,
>   	}
>   
>   	if (memcmp(buf, "disconnect ", 11) == 0) {
> -		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn);
> +		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn, true);
>   		if (ret < 0)
>   			return ret;
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

